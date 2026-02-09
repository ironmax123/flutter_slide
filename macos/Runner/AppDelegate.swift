import Cocoa
import FlutterMacOS
import multi_window_native

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationDidFinishLaunching(_ notification: Notification) {
    MultiWindowNativePlugin.onEngineCreatedCallback = { engine in
      RegisterGeneratedPlugins(registry: engine)
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
