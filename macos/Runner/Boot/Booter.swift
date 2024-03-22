import Foundation
import FlutterMacOS

class Booter {
    static func boot(flutterViewController: FlutterViewController) {
        _ = MediaChannel(flutterViewController: flutterViewController)
    }
}
