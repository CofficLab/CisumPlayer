import 'package:audioplayers/audioplayers.dart';
import 'package:cisum/entities/audio.dart';
import 'package:cisum/entities/logger.dart';
import 'package:cisum/entities/playlist.dart';

mixin PlayControlMixin {
  AudioPlayer player = AudioPlayer();
  PlaylistModel list = PlaylistModel.emptyPlayList;

  String getTitle() {
    return list.getCurrent().getTitle();
  }

  Future<String> getPosition() async {
    return (await player.getCurrentPosition())!.inSeconds.toString();
  }

  PlayerState getState() {
    return player.state;
  }

  void pause(String reason) {
    logger.d("PlayControlMixin::pause, for $reason");
    player.pause();
  }

  void play(String reason) {
    logger.d("PlayControlMixin::play 🐛 $reason");

    if (list.getCurrent().isEmpty()) {
      logger.d("PlayControlMixin::play, this.audio is empty");
      return;
    }

    switch (player.state) {
      case PlayerState.paused:
        player.resume();
        break;
      case PlayerState.stopped:
        player.play(DeviceFileSource(list.getCurrent().file.path),
            mode: PlayerMode.mediaPlayer, position: const Duration(seconds: 0));
      case PlayerState.playing:
      default:
        break;
    }
  }

  void seek(String reason, Duration duration) {
    logger.d("SmartPlayer::seek, duration: $duration,for $reason");
    player.seek(duration);
  }

  PlaylistModel getPlaylist() {
    return list;
  }

  AudioModel getNextAudio(String reason) {
    return list.getNext();
  }

  AudioModel getPreviousAudio(String reason) {
    return list.getPre();
  }

  void deleteAudio(AudioModel audio) {
    list.delete(audio);
  }

  void setPlaylist(PlaylistModel playlist) {
    list = playlist;
  }

  dispose() {
    player.stop();
    player.dispose();
  }
}
