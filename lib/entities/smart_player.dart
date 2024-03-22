import 'package:audioplayers/audioplayers.dart';
import 'package:cisum/channels/media_channel.dart';
import 'package:cisum/entities/audio.dart';
import 'package:cisum/entities/database.dart';
import 'package:cisum/entities/logger.dart';
import 'package:cisum/entities/playlist.dart';

class SmartPlayer {
  final AudioPlayer player = AudioPlayer();
  final Function onPlaying;
  final Function onPaused;
  final Function onAudioChange;
  var playList = PlaylistModel.emptyPlayList;
  var audio = AudioModel.emptyAudioModel;
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

    DatabaseModel.getPlaylist().then((value) {
      playList = value;
      audio = playList.audios.first;
    });

    player.setPlayerMode(PlayerMode.mediaPlayer);

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
    });
  }

  PlayerState getState() {
    return player.state;
  }

  setAudio(AudioModel audio) {
    this.audio = audio;
    player.setSourceDeviceFile(audio.file.path);
    updateMediaCenter();
    onAudioChange();
    logger.d("SmartPlayer::设置当前Audio: ${audio.getTitle()}");
  }

  play(String reason, {AudioModel? audio}) {
    logger.d("SmartPlayer::play, for $reason");
    if (audio != null) {
      setAudio(audio);
    }

    switch (player.state) {
      case PlayerState.paused:
        player.resume();
        break;
      case PlayerState.stopped:
        player.play(DeviceFileSource(this.audio.file.path),
            mode: PlayerMode.mediaPlayer, position: const Duration(seconds: 0));
      case PlayerState.playing:
      default:
        break;
    }
  }

  seek(String reason, Duration duration) {
    logger.d("SmartPlayer::seek, duration: $duration,for $reason");
    player.seek(duration);
  }

  next(String reason) {
    logger.d("SmartPlayer::next, for $reason");
    setAudio(playList.getNext());
  }

  pre(String reason) {
    logger.d("SmartPlayer::pre, for $reason");
    setAudio(playList.getPre());
  }

  pause(String reason) {
    logger.d("SmartPlayer::pause, for $reason");
    player.pause();
  }

  toggle() async {
    if (player.state == PlayerState.playing) {
      return await player.pause();
    }

    if (player.state == PlayerState.paused) {
      return await player.resume();
    }

    if (player.state == PlayerState.stopped) {
      return await play("toggle", audio: audio);
    }

    if (player.state == PlayerState.completed) {
      return;
    }
  }

  updateMediaCenter() async {
    mediaChannel.setMeta(
        audio: audio, state: getState().name, current: (await player.getCurrentPosition())!.inSeconds.toString());
  }

  getTitle() {
    return audio.getTitle();
  }

  dispose() {
    player.stop();
    player.dispose();
  }
}
