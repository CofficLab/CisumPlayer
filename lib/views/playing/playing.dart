import 'package:cisum/provider/player.dart';
import 'package:cisum/views/playing/play_control.dart';
import 'package:cisum/views/playing/play_cover.dart';
import 'package:cisum/views/playing/play_slider.dart';
import 'package:cisum/views/playing/play_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Playing extends StatefulWidget {
  const Playing({super.key});

  @override
  State<Playing> createState() => _PlayingState();
}

class _PlayingState extends State<Playing> {
  @override
  Widget build(BuildContext context) {
    final player = context.read<PlayerProvider>().player;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.withOpacity(0.8), Colors.green.withOpacity(0.8)], // 定义渐变色的起始颜色和结束颜色
          begin: Alignment.centerLeft, // 渐变色的起始位置
          end: Alignment.centerRight, // 渐变色的结束位置
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Center(
                    child: PlayTitle(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: PlayControl(),
                ),
                Expanded(
                  flex: 2,
                  child: PlaySlider(),
                )
              ],
            ),
          ),
          Visibility(
            visible: shouldShowCover(),
            child: const Expanded(
              flex: 3,
              child: PlayCover(),
            ),
          )
        ],
      ),
    );
  }

  shouldShowCover() {
    final media = MediaQuery.of(context);
    return media.size.width > 800;
  }
}
