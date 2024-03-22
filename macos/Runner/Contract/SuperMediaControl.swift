import Foundation
import OSLog

class SuperMediaControlSample: SuperMediaControl {}

protocol SuperMediaControl {
    func onPause()
    func next()
    func prev()
    func play()
    func pause()
    func stop()
    func like()
    func rate()
    func changeRepeatModeCommand()
    func changePlaybackPositionCommand(_ t: TimeInterval)
}

extension SuperMediaControl {
    func onPause() {
        os_log("onPause")
    }
    
    func next() {
        os_log("next")
    }
    
    func prev() {
        os_log("prev")
    }
    
    func play() {
        os_log("play")
    }

    func pause() {
        os_log("pause")
    }
    
    func stop() {
        os_log("stop")
    }
    
    func like() {
        os_log("like")
    }
    
    func rate() {
        os_log("rate")
    }
    
    func changeRepeatModeCommand() {
        os_log("changeRepeatModeCommand")
    }
    
    func changePlaybackPositionCommand(_ t: TimeInterval) {
        os_log("changePlaybackPositionCommand to \(t.description)")
    }
}
