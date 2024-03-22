import AVKit
import Foundation
import MediaPlayer
import OSLog
import SwiftUI

class MediaPlayerManager: ObservableObject {
    var delegate: SuperMediaControl
    init(delegate: SuperMediaControl) {
        self.delegate = delegate
        onCommand()
  }

    func setNowPlayingInfo(title: String, artist: String, duration: String,current: String, state: MPNowPlayingPlaybackState) {
    os_log("更新 MediaPlayer")
    let center = MPNowPlayingInfoCenter.default()

    #if os(iOS)
      audio.getAudioMeta { metaData in
        let image = metaData.uiImage

        center.nowPlayingInfo = [
          MPMediaItemPropertyTitle: audioManager.audio.title,
          MPMediaItemPropertyArtwork: MPMediaItemArtwork(boundsSize: image.size) { _ -> UIImage in
            image
          },
          MPMediaItemPropertyArtist: artist,
          MPMediaItemPropertyPlaybackDuration: audioManager.duration,
          MPNowPlayingInfoPropertyElapsedPlaybackTime: audioManager.currentTime(),
        ]
      }
    #else
      center.playbackState = state
      center.nowPlayingInfo = [
        MPMediaItemPropertyTitle: title,
        MPMediaItemPropertyArtist: artist,
        MPMediaItemPropertyPlaybackDuration: duration,
        MPNowPlayingInfoPropertyElapsedPlaybackTime: current,
      ]
    #endif
  }

  // 接收控制中心的指令
  private func onCommand() {
    let commandCenter = MPRemoteCommandCenter.shared()

    commandCenter.nextTrackCommand.addTarget { _ in
        self.delegate.next()

      return .success
    }

    commandCenter.previousTrackCommand.addTarget { _ in
        self.delegate.prev()
      return .success
    }

    commandCenter.pauseCommand.addTarget { _ in
        self.delegate.pause()

      return .success
    }

    commandCenter.playCommand.addTarget { _ in
        self.delegate.play()

      return .success
    }

    commandCenter.stopCommand.addTarget { _ in
        self.delegate.stop()

      return .success
    }

    commandCenter.likeCommand.addTarget { _ in
        self.delegate.like()

      return .success
    }

    commandCenter.ratingCommand.addTarget { _ in
        self.delegate.rate()

      return .success
    }

    commandCenter.changeRepeatModeCommand.addTarget { _ in
        self.delegate.changeRepeatModeCommand()

      return .success
    }
      
      commandCenter.changePlaybackPositionCommand.addTarget { e in
          os_log("🍎 changePlaybackPositionCommand")
          guard let event = e as? MPChangePlaybackPositionCommandEvent else {
                  return .commandFailed
              }
              
              let positionTime = event.positionTime // 获取当前的播放进度时间
              
              // 在这里处理当前的播放进度时间
              print("Current playback position: \(positionTime)")
          self.delegate.changePlaybackPositionCommand(positionTime)
              
              return .success
      }
  }
}
