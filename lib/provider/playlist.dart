import 'package:cisum/entities/audio.dart';
import 'package:cisum/entities/database.dart';
import 'package:cisum/entities/logger.dart';
import 'package:cisum/entities/playlist.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  var playList = PlaylistModel.emptyPlayList;

  PlaylistProvider() {
    DatabaseModel.getPlaylist().then((value) {
      playList = value;
      logger.d("PlaylistProvider::初始化后获取列表成功");
      notifyListeners();
    });
  }

  refresh() async {
    playList = await DatabaseModel.getPlaylist();
    notifyListeners();
  }

  delete(AudioModel audio) {
    audio.delete();
    refresh();
  }
}
