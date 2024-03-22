import Cocoa
import FlutterMacOS
import Foundation
import IOKit.ps
import OSLog
import SwiftUI

class DataChannel {
    private var db: SuperDB
    
    init(db: SuperDB) {
        self.db = db
    }
    
    func make(flutterViewController: FlutterViewController) -> FlutterMethodChannel {
        let ch = FlutterMethodChannel(
            name: "app/data",
            binaryMessenger: flutterViewController.engine.binaryMessenger)
        
        ch.setMethodCallHandler { call, result in
            os_log("🍎 app/data 收到消息 -> \(call.method)")
            switch call.method {
            case "create":
                os_log("🍎 app/data 处理 -> \(call.method)")
                result(self.db.create())
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return ch
    }
}
