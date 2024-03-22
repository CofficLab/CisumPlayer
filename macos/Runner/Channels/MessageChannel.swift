import Cocoa
import FlutterMacOS
import Foundation
import IOKit.ps
import OSLog

class MessageChannel {
  private var ch: FlutterMethodChannel

  init(flutterViewController: FlutterViewController) {
    self.ch = FlutterMethodChannel(
      name: "app/message",
      binaryMessenger: flutterViewController.engine.binaryMessenger)

    ch.setMethodCallHandler { call, result in
      os_log("🍎 app/message 收到消息 -> \(call.method)")
      switch call.method {
      case "create":
        os_log("🍎 app/message 处理 -> \(call.method)")
        result("🍎 收到了")
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  func sendMessage(_ s: String) {
    os_log("🍎 向 Flutter 发送消息")
    self.ch.invokeMethod("x", arguments: s)
  }
}
