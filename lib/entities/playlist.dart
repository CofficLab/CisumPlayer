import 'dart:io';
import 'dart:math';

import 'package:coffic/entities/audio.dart';

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

    return audios[++current % audios.length];
  }

  getPre() {
    if (shuffled) {
      return audios[Random().nextInt(audios.length)];
    }

    return audios[--current % audios.length];
  }

  AudioModel getCurrent() {
    if (audios.isEmpty) return AudioModel.emptyAudioModel;

    return audios[current];
  }

  File getCurrentFile() {
    return getCurrent().file;
  }

  String getCurrentPath() {
    return getCurrentFile().path;
  }

  getAudios() {
    return audios;
  }

  String activate(AudioModel audio) {
    return setCurrent(audio);
  }

  String setCurrent(AudioModel audio) {
    current = audios.indexOf(audio);
    return getCurrentPath();
  }

  void delete(AudioModel audio) {
    if (current >= audios.length) {
      current = 0;
    }

    if (audios.isEmpty) {
      current = 0;
    }

    audios.remove(audio);
    audio.delete();
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
