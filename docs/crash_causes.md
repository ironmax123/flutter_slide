# クラッシュ原因調査レポート

現在の実装コード（`Base2.dart` および `AppDelegate.swift`）を調査し、アプリケーションがクラッシュする、あるいは予期せぬ動作をする可能性のある箇所を特定しました。

## 1. Dart側：ポート競合による未捕捉の例外

### 現象
`Base2.dart` の `startServer` メソッドにおいて、`ServerSocket.bind` が `try-catch` ブロックの外で実行されています。

```dart
// Base2.dart
Future<void> startServer() async {
  final port = int.tryParse(portController.text) ?? 8000;
  // ここでポートが既に使われているとSocketExceptionが発生するが、catchされていない
  final s = await ServerSocket.bind(hostname, port); 
  
  server.value = s;
  // ...
  
  try {
    server.value?.listen(...)
  } on SocketException catch (ex) { ... }
}
```

### 原因
指定したポート（デフォルト8000）が既に他のアプリケーション（または前回の起動プロセス）によって使用されている場合、`ServerSocket.bind` は例外をスローします。これが捕捉されないため、アプリケーション（特にサブウィンドウの処理）が中断し、フリーズしたように見えるか、最悪の場合クラッシュします。

### 対策
`ServerSocket.bind` を `try-catch` ブロックで囲み、エラー時にユーザーへ通知する、またはログを出力する処理を追加する必要があります。

---

## 2. Native側 (macOS)：メインスレッド外でのUIアクセス

### 現象
`AppDelegate.swift` の `server_state` チャンネルのハンドラ内で、`NSApp.windows` にアクセスしています。

```swift
// AppDelegate.swift
stateChannel.setMethodCallHandler { call, result in
    if call.method == "setServerPort" {
        // ...
        // NSApp.windows へのアクセスはメインスレッドで行うことが推奨される
        let windows = NSApp.windows 
        for window in windows { ... }
        // ...
    }
}
```

### 原因
Flutterの `MethodChannel` は通常メインスレッド（Platform Thread）で呼び出されますが、非同期処理やスレッドのコンテキストによっては保証されない場合があります。`NSApp` や `NSWindow` などのAppKitクラスは **Main Thread Only** であり、万が一バックグラウンドスレッドからアクセスされた場合、即座にクラッシュ（`EXC_BAD_INSTRUCTION` 等）を引き起こします。

リサイズ処理（`window_control`）では `DispatchQueue.main.async` を使用していますが、ポート共有処理（`server_state`）では使用されていません。

### 対策
`setServerPort` の処理も `DispatchQueue.main.async` でラップし、確実にメインスレッドで実行されるように保証する必要があります。

---

## 3. Native側：ウィンドウの生存期間とエンジンの参照

### 現象
ウィンドウをイテレーションして `flutterVC.engine` にアクセスし、メソッドを呼び出しています。

### 原因
ウィンドウが閉じられる最中や、Flutterエンジンが破棄された直後にこの処理が走った場合、無効なオブジェクトへのアクセスが発生する可能性があります。Swiftの `optional` バインディング（`if let`）である程度守られていますが、タイミングによっては不安定になる可能性があります。

### 対策
現状の実装でもリスクは低いですが、`DispatchQueue.main.async` でメインスレッドに処理を寄せることで、競合状態を回避しやすくなります。

---

## 結論と推奨される修正

最も可能性が高い原因は **1. ポート競合** と **2. スレッド不整合** です。以下の修正を行うことを強く推奨します。

1.  **Base2.dart**: `ServerSocket.bind` を `try-catch` で囲む。
2.  **AppDelegate.swift**: `setServerPort` 内の処理を `DispatchQueue.main.async { ... }` で囲む。
