import 'package:audioplayers/audioplayers.dart';
import 'package:coffic/channels/media_channel.dart';
import 'package:coffic/entities/audio.dart';
import 'package:coffic/entities/logger.dart';
import 'package:coffic/entities/smart_player.dart';
import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier {
  late SmartPlayer player;
  late MediaChannel mediaChannel;

  PlayerProvider() {
    player = SmartPlayer();
    player.onAudioChanged(notifyListeners);
    player.onPlaying(notifyListeners);
  }

  AudioModel getAudio() {
    return player.getPlaylist().getCurrent();
  }

  String getTitle() {
    return player.getTitle();
  }

  bool isPlaying() {
    return player.getState() == PlayerState.playing;
  }

  toggle() async {
    await player.toggle();
    notifyListeners();
  }

  void delete(AudioModel audio) {
    player.deleteAudio(audio);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    logger.d("PlayerProvider::dispose");
    player.dispose();
  }
}
