import 'package:cisum/entities/audio.dart';
import 'package:cisum/provider/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayCover extends StatelessWidget {
  const PlayCover({super.key});

  @override
  Widget build(BuildContext context) {
    var audio = context.select<PlayerProvider, AudioModel>((value) => value.getAudio());
    return Padding(padding: const EdgeInsets.all(8.0), child: audio.getCover());
  }
}
