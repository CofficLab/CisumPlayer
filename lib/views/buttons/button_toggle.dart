import 'package:coffic/components/button_control.dart';
import 'package:coffic/provider/player.dart';
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
    var playing = context.select<PlayerProvider, bool>((PlayerProvider state) => state.isPlaying());
    return ButtonControl(
      icon: Icon(playing ? Icons.pause : Icons.play_arrow),
      onPressed: () async {
        await context.read<PlayerProvider>().toggle();
      },
    );
  }
}
