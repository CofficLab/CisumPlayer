import 'dart:io';
import 'dart:typed_data';

import 'package:cisum/entities/audio.dart';
import 'package:cisum/entities/logger.dart';
import 'package:cisum/entities/playlist.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class DatabaseModel {
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

  static Future<PlaylistModel> getPlaylist() async {
    var appDocDirPath = await getAudiosDir();
    var appDocDir = Directory(appDocDirPath);
    var fileList = appDocDir.listSync(recursive: true);
    var audioFileList = fileList.where((element) => element.statSync().type == FileSystemEntityType.file).toList();
    var audios = audioFileList.map((e) => AudioModel(file: File(e.path))).toList();

    return PlaylistModel(audios: audios);
  }

  static saveFile(reader) async {
    logger.i("saveFile");

    if (reader.canProvide(Formats.dmg)) {
      await reader.getFile(Formats.dmg, (file) async {
        await saveStreamAsFile(file.getStream(), file.fileName ?? "input.dmg");
      }, onError: (error) {
        debugPrint('Error reading value $error');
      });
    }

    if (reader.canProvide(Formats.mp3)) {
      await reader.getFile(Formats.mp3, (file) async {
        await saveStreamAsFile(file.getStream(), file.fileName ?? "input.dmg");
      }, onError: (error) {
        debugPrint('Error reading value $error');
      });
    }
  }

  static Future<void> saveStreamAsFile(Stream<Uint8List> stream, String fileName) async {
    logger.d("save file with name $fileName");
    var audiosDir = await getAudiosDir();
    var savedPath = path.join(audiosDir, fileName);
    final file = File(savedPath); // 保存的文件路径

    IOSink sink = file.openWrite();

    await for (Uint8List data in stream) {
      sink.add(data);
    }

    await sink.close();
  }
}
