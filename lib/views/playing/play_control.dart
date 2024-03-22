import 'package:cisum/views/buttons/button_next.dart';
import 'package:cisum/views/buttons/button_pre.dart';
import 'package:cisum/views/buttons/button_toggle.dart';
import 'package:flutter/material.dart';

class PlayControl extends StatelessWidget {
  const PlayControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.withOpacity(0),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ButtonList(player: player),
          ButtonPre(),
          ButtonToggle(),
          ButtonNext(),
          // ButtonMode(player: player),
        ],
      ),
    );
  }
}
