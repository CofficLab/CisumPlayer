import 'package:cisum/components/button_control.dart';
import 'package:cisum/provider/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonNext extends StatelessWidget {
  const ButtonNext({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0),
      constraints: const BoxConstraints(maxWidth: 60),
      child: ButtonControl(
          icon: const Icon(Icons.skip_next_rounded),
          onPressed: () {
            context.read<PlayerProvider>().player.next("点击了下一首");
          }),
    );
  }
}
