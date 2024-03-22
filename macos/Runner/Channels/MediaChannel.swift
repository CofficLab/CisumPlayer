import Cocoa
import FlutterMacOS
import Foundation
import IOKit.ps
import MediaPlayer
import OSLog

class MediaChannel {
    private var ch: FlutterMethodChannel
    private var mm: MediaPlayerManager?

    init(flutterViewController: FlutterViewController) {
        ch = FlutterMethodChannel(
            name: "app/media",
            binaryMessenger: flutterViewController.engine.binaryMessenger)

        ch.setMethodCallHandler { call, result in
            os_log("🍎 app/media 收到消息 -> \(call)")
            switch call.method {
            case "setMeta":
                result(self.setMeta(call.arguments))
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        mm = MediaPlayerManager(delegate: self)
    }

    func setMeta(_ arguments: Any?) -> String {
        var title = ""
        var artist = ""
        var duration: String = "0"
        var current: String = "0"
        var state: MPNowPlayingPlaybackState = .unknown

        if let arguments = arguments as? [String: Any] {
            title = arguments["title"] as? String ?? ""
            artist = arguments["artist"] as? String ?? ""
            duration = arguments["duration"] as? String ?? "0"
            current = arguments["current"] as? String ?? "0"
            state = getStateFromString(arguments["state"] as? String ?? "")
        }

        mm!.setNowPlayingInfo(title: title, artist: artist, duration: duration,current: current, state: state)
        return "🍎 收到消息，duration=\(duration)，state=\(state.description), current=\(current)"
    }

    func getStateFromString(_ s: String) -> MPNowPlayingPlaybackState {
        if s == "playing" {
            return .playing
        }

        if s == "paused" {
            return .paused
        }

        if s == "interrupted" {
            return .interrupted
        }

        return .unknown
    }
}

extension MediaChannel: SuperMediaControl {
    func next() {
        ch.invokeMethod("next", arguments: nil)
    }

    func prev() {
        ch.invokeMethod("prev", arguments: nil)
    }

    func pause() {
        ch.invokeMethod("pause", arguments: nil)
    }

    func play() {
        ch.invokeMethod("play", arguments: nil)
    }
    
    func changePlaybackPositionCommand(_ t: TimeInterval) {
        ch.invokeMethod("changePlaybackPositionCommand", arguments: t)
    }
}

extension MPNowPlayingPlaybackState {
    var description: String {
        switch self {
        case .unknown:
            return "unknown"
        case .playing:
            return "playing"
        case .paused:
            return "paused"
        case .stopped:
            return "stopped"
        case .interrupted:
            return "interrupted"
        @unknown default:
            return "unknown"
        }
    }
}
