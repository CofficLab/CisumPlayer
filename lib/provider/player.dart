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
    return player.audio;
  }

  String getTitle() {
    return player.getTitle();
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
  }

  toggle() async {
    logger.d("PlayerProvider::toggle");
    await player.toggle();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    logger.d("PlayerProvider::dispose");
    player.dispose();
  }
}
