# slides_for_mac

Flutterで作成されたプレゼンテーション用スライドアプリです。
主にFlutterにおけるフォルダブル端末や大画面（Android 16, Android XRなど）への対応について解説するスライドが含まれています。

## 概要

このプロジェクトは、プレゼンテーションスライド自体をFlutterアプリケーションとして実装したものです。
キーボードの矢印キーでスライドを操作でき、レスポンシブなレイアウトや実際のコード例を交えた解説が可能です。

## 主なトピック

- Flutterでのフォルダブル（Foldable）対応
- Android 16 / Android XR における大画面対応
- レスポンシブデザインの実装例（`NavigationRail`など）

## 技術スタック

- **Framework**: Flutter
- **State Management**: Riverpod (Hooks Riverpod)
- **Code Generation**: Freezed, Riverpod Generator
- **Routing**: GoRouter
- **UI Utilities**: Gap, Flutter Hooks

## 実行方法

```bash
flutter pub get
flutter run -d macos
```

## ディレクトリ構成

- `lib/pages/`: 各スライドページの実装
- `lib/viewmodel/`: スライドの状態管理（ページ遷移など）
- `lib/pages/components/`: 共通コンポーネント（AppBar, Textなど）
