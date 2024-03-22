import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ControlAction {
  static stop(AudioPlayer player) {
    player.stop();
  }

  static play(AudioPlayer player, String filePath) {
    player.play(DeviceFileSource(filePath));
  }

  static toggle(AudioPlayer player, String filePath) {
    if (player.state == PlayerState.playing) {
      return player.pause();
    }

    if (player.state == PlayerState.paused) {
      return player.resume();
    }

    if (player.state == PlayerState.stopped) {
      return player.play(DeviceFileSource(filePath));
    }
  }

  static onCurrentFileChanged(AudioPlayer player, String filePath) {
    player.stop();
    player.play(DeviceFileSource(filePath));
  }

  static double getButtonSize(BuildContext context) {
    if (MediaQuery.of(context).size.width > 800) {
      return 80;
    }

    if (MediaQuery.of(context).size.width > 350) {
      return 30;
    }

    return 20;
  }
}
