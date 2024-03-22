import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class AudioModel {
  const AudioModel({required this.file});

  static var emptyAudioModel = AudioModel(file: File(''));

  final File file;

  static Future<String> getAudiosDir() async {
    var appDocDir = await getApplicationDocumentsDirectory();
    var audioDir = path.join(appDocDir.path, 'audios');

    Directory newDirectory = Directory(audioDir);
    if (!(await newDirectory.exists())) {
      await newDirectory.create(recursive: true);
      debugPrint('Directory created: $audioDir');
    }

    return audioDir;
  }

  bool sameTo(AudioModel audio) {
    return file.path == audio.file.path;
  }

  delete() {
    file.deleteSync();
  }

  isNotEmpty() {
    return file.path != "";
  }

  isEmpty() {
    return file.path == "";
  }

  getTitle() {
    String title = path.basename(file.path);
    String extension = path.extension(file.path);
    title = title.replaceAll(extension, "");
    return title;
  }

  getCover() {
    return Image.asset(
      'assets/images/cover.png', // 替换成您的图片路径
      // width: 200, // 设置图片宽度
      // height: 200, // 设置图片高度
      fit: BoxFit.fitHeight, // 设置图片填充方式
    );
  }

  Future<Duration> getDuration() async {
    var player = AudioPlayer();
    await player.setSourceDeviceFile(file.path);
    var duration = await player.getDuration();
    player.dispose();

    return duration!;
  }

  Future<int> getDurationInSeconds() async {
    return getDuration().then((value) => value.inSeconds);
  }

  toText() {
    return Text(getTitle());
  }

  Future<Map<String, String>> getMeta() async {
    return <String, String>{
      'title': getTitle(),
      'artist': "Cisum",
      'duration': (await getDurationInSeconds()).toString()
    };
  }
}
