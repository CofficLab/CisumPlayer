import 'dart:io';

import 'package:cisum/entities/audio.dart';
import 'package:cisum/provider/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_context_menu/super_context_menu.dart';

class DatabaseCell extends StatelessWidget {
  const DatabaseCell({super.key, required this.audio});

  final AudioModel audio;

  @override
  Widget build(BuildContext context) {
    var playerProvider = context.read<PlayerProvider>();

    return ContextMenuWidget(
      child: Container(
        alignment: Alignment.centerLeft,
        color: Colors.amber.withOpacity(0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(padding: const EdgeInsets.only(right: 4, top: 2, bottom: 2), child: audio.getCover()),
              Text(
                audio.getTitle(),
              ),
            ],
          ),
        ),
      ),
      menuProvider: (_) {
        return Menu(
          children: [
            MenuAction(
                callback: () {
                  playerProvider.player.setAudio(audio);
                  playerProvider.player.play("右键单击播放");
                },
                title: '播放'),
            MenuAction(
                title: '在Finder中显示',
                callback: () {
                  Process.run('open', ['-R', audio.file.path]);
                }),
            MenuSeparator(),
            // Menu(title: 'Submenu', children: [
            //   MenuAction(title: 'Submenu Item 1', callback: () {}),
            //   MenuAction(title: 'Submenu Item 2', callback: () {}),
            //   Menu(title: 'Nested Submenu', children: [
            //     MenuAction(title: 'Submenu Item 1', callback: () {}),
            //     MenuAction(title: 'Submenu Item 2', callback: () {}),
            //   ]),
            // ]),
            MenuAction(
                title: '删除',
                callback: () {
                  audio.delete();
                  context.read<PlayerProvider>().delete(audio);
                }),
          ],
        );
      },
    );
  }
}
