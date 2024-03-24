import 'package:audioplayers/audioplayers.dart';
import 'package:coffic/components/button_control.dart';
import 'package:flutter/material.dart';

class ButtonMode extends StatelessWidget {
  const ButtonMode({super.key, required this.player});

  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0),
      constraints: const BoxConstraints(maxWidth: 60),
      child: ButtonControl(icon: const Icon(Icons.shuffle), onPressed: () {}),
    );
  }
}
