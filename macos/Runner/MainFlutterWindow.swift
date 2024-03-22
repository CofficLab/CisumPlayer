import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    private var booter = Booter()
    private var batteryChannel: FlutterMethodChannel?
    private var messageChannel: MessageChannel?
    private var mediaChannel: MediaChannel?
    private var dataChannel: FlutterMethodChannel?

    override func awakeFromNib() {
        let flutterViewController = FlutterViewController()
        let windowFrame = frame
        contentViewController = flutterViewController
        setFrame(windowFrame, display: true)

        Booter.boot(flutterViewController: flutterViewController)

        RegisterGeneratedPlugins(registry: flutterViewController)

        super.awakeFromNib()
    }
}
