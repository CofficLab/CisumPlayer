import 'package:audioplayers/audioplayers.dart';
import 'package:cisum/components/button_control.dart';
import 'package:cisum/provider/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonPre extends StatelessWidget {
  const ButtonPre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red.withOpacity(0),
        constraints: const BoxConstraints(maxWidth: 60),
        child: ButtonControl(
            icon: const Icon(Icons.skip_previous),
            onPressed: () {
              context.read<PlayerProvider>().pre();
            }));
  }
}
