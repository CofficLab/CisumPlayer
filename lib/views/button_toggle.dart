import 'package:audioplayers/audioplayers.dart';
import 'package:cisum/components/button_control.dart';
import 'package:cisum/provider/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonToggle extends StatefulWidget {
  const ButtonToggle({super.key});

  @override
  State<ButtonToggle> createState() => _ButtonToggleState();
}

class _ButtonToggleState extends State<ButtonToggle> {
  @override
  Widget build(BuildContext context) {
    PlayerState state = context.select<PlayerProvider, PlayerState>((PlayerProvider state) => state.player.getState());
    return ButtonControl(
      icon: Icon(state == PlayerState.playing ? Icons.pause : Icons.play_arrow),
      onPressed: () async {
        await context.read<PlayerProvider>().toggle();
      },
    );
  }
}
