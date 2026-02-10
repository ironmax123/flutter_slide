import Cocoa
import FlutterMacOS
import multi_window_native

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationDidFinishLaunching(_ notification: Notification) {
    MultiWindowNativePlugin.onEngineCreatedCallback = { engine in
      RegisterGeneratedPlugins(registry: engine)
      
      // Setup channel to handle window control (e.g. resizing)
      let windowChannel = FlutterMethodChannel(name: "com.example.slides_for_mac/window_control", binaryMessenger: engine.binaryMessenger)
      windowChannel.setMethodCallHandler { call, result in
        // ... (resizing logic remains same) ...
        if call.method == "resizeWindow" {
           if let args = call.arguments as? [String: Any],
              let width = args["width"] as? Double,
              let height = args["height"] as? Double {
               
               DispatchQueue.main.async {
                   let windows = NSApp.windows
                   for window in windows {
                       if let flutterVC = window.contentViewController as? FlutterViewController,
                          flutterVC.engine === engine {
                           var frame = window.frame
                           let oldHeight = frame.size.height
                           frame.size = NSSize(width: width, height: height)
                           frame.origin.y += (oldHeight - height)
                           window.setFrame(frame, display: true, animate: true)
                           result(nil)
                           return
                       }
                   }
                   result(FlutterError(code: "WINDOW_NOT_FOUND", message: "Could not find window for engine", details: nil))
               }
           } else {
               result(FlutterError(code: "INVALID_ARGS", message: "Width and height required", details: nil))
           }
        } else {
            result(FlutterMethodNotImplemented)
        }
      }

      // Setup channel for shared server state
      let stateChannel = FlutterMethodChannel(name: "com.example.slides_for_mac/server_state", binaryMessenger: engine.binaryMessenger)
      stateChannel.setMethodCallHandler { call, result in
          if call.method == "setServerPort" {
              if let args = call.arguments as? [String: Any],
                 let port = args["port"] as? Int {
                  // Broadcast to all engines
                  DispatchQueue.main.async {
                      let windows = NSApp.windows
                      for window in windows {
                          if let flutterVC = window.contentViewController as? FlutterViewController {
                               let channel = FlutterMethodChannel(name: "com.example.slides_for_mac/server_state", binaryMessenger: flutterVC.engine.binaryMessenger)
                               channel.invokeMethod("onServerPortChanged", arguments: ["port": port])
                          }
                      }
                      result(nil)
                  }
              }
          } else {
              result(FlutterMethodNotImplemented)
          }
      }
    }
    super.applicationDidFinishLaunching(notification)
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
