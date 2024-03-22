import Cocoa
import FlutterMacOS
import Foundation
import IOKit.ps

class BatteryChannel {
    func make(flutterViewController: FlutterViewController) -> FlutterMethodChannel {
        let batteryChannel = FlutterMethodChannel(
            name: "app/battery",
            binaryMessenger: flutterViewController.engine.binaryMessenger)
        batteryChannel.setMethodCallHandler { call, result in
            switch call.method {
            case "getBatteryLevel":
                guard let level = self.getBatteryLevel() else {
                    result(
                        FlutterError(
                            code: "UNAVAILABLE",
                            message: "Battery level not available",
                            details: nil))
                    return
                }
                result(level)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return batteryChannel
    }

    private func getBatteryLevel() -> Int? {
        return 10000
    }
}
