import 'dart:math';

import 'package:cisum/entities/audio.dart';

class PlaylistModel {
  PlaylistModel({required this.audios});

  static PlaylistModel emptyPlayList = PlaylistModel(audios: []);

  List<AudioModel> audios;
  int current = 0;
  bool shuffled = false;

  getNext() {
    if (shuffled) {
      return audios[Random().nextInt(audios.length)];
    }

    return audios[current++ % audios.length];
  }

  getPre() {
    if (shuffled) {
      return audios[Random().nextInt(audios.length)];
    }

    return audios[current-- % audios.length];
  }

  getAudios() {
    return audios;
  }

  setShuffled() {
    shuffled = true;
    current = 0;
  }

  setUnShuffled() {
    shuffled = false;
    current = 0;
  }
}
