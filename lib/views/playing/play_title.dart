import 'package:coffic/provider/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayTitle extends StatelessWidget {
  const PlayTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amber.withOpacity(0),
        child: Center(
          child: Consumer<PlayerProvider>(
            builder: (context, audioState, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      audioState.getAudio().getTitle(),
                      style: TextStyle(fontSize: getFontSize(context), color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  double getFontSize(BuildContext context) {
    if (MediaQuery.of(context).size.width > 350) {
      return 18;
    }

    return 18;
  }
}
