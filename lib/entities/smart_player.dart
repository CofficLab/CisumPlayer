import 'package:audioplayers/audioplayers.dart';
import 'package:cisum/channels/media_channel.dart';
import 'package:cisum/entities/audio.dart';
import 'package:cisum/entities/logger.dart';
import 'package:cisum/mixin/play_control.dart';

class SmartPlayer with PlayControlMixin {
  final Function onPlaying;
  final Function onPaused;
  final Function onAudioChange;
  late MediaChannel mediaChannel;

  SmartPlayer({required this.onPlaying, required this.onPaused, required this.onAudioChange}) {
    mediaChannel = MediaChannel(onPause: () {
      pause("MediaChannel asked to pause");
    }, onPlay: () {
      play("MediaChannel asked to play");
    }, onPrev: () {
      pre("MediaChannel asked to pre");
    }, onNext: () {
      next("MediaChannel asked to next");
    }, onChangePlaybackPosition: (double duration) {
      seek("MediaChannel asked to onChangePlaybackPositionCommand",
          Duration(microseconds: (duration * 1000 * 1000).toInt()));
    });

    player.onPlayerStateChanged.listen((event) {
      updateMediaCenter();

      switch (event) {
        case PlayerState.playing:
          logger.d("SmartPlayer::onPlaying");
          onPlaying();
          break;
        case PlayerState.paused:
          onPaused();
          break;
        default:
          break;
      }
    });

    player.onPlayerComplete.listen((event) {
      next("onPlayerComplete");
      player.resume();
    });
  }

  setAudio(AudioModel audio) async {
    await player.setSourceDeviceFile(list.activate(audio));
    updateMediaCenter();
    onAudioChange();
  }

  next(String reason) {
    logger.d("SmartPlayer::next 🐛 $reason");
    setAudio(getNextAudio(reason));
  }

  pre(String reason) {
    setAudio(getPreviousAudio(reason));
  }

  toggle() async {
    if (player.state == PlayerState.playing) {
      return await player.pause();
    }

    if (player.state == PlayerState.paused) {
      return await player.resume();
    }

    if (player.state == PlayerState.stopped) {
      return await play("PlayControlMixin::toggle");
    }

    if (player.state == PlayerState.completed) {
      return player.resume();
    }
  }

  updateMediaCenter() async {
    mediaChannel.setMeta(audio: list.getCurrent(), state: getState().name, current: await getCurrentPosition());
  }
}
