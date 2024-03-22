import 'package:audioplayers/audioplayers.dart';
import 'package:cisum/channels/media_channel.dart';
import 'package:cisum/entities/audio.dart';
import 'package:cisum/entities/logger.dart';
import 'package:cisum/entities/smart_player.dart';
import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier {
  late SmartPlayer player;
  late MediaChannel mediaChannel;

  PlayerProvider() {
    player = SmartPlayer(onPlaying: () {
      notifyListeners();
    }, onPaused: () {
      notifyListeners();
    }, onAudioChange: () {
      notifyListeners();
    });
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

  next() {
    player.next("PlayerProvider::next");
    notifyListeners();
  }

  pre() {
    player.pre("PlayerProvider::pre");
    notifyListeners();
  }

  play({AudioModel? audio}) {
    player.play("PlayerProvider::play", audio: audio);
    notifyListeners();
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
