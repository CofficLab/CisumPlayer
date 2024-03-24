import 'package:audioplayers/audioplayers.dart';
import 'package:coffic/provider/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaySlider extends StatefulWidget {
  const PlaySlider({super.key});

  @override
  State<PlaySlider> createState() => _PlaySliderState();
}

class _PlaySliderState extends State<PlaySlider> {
  double _currentSliderValue = 0.0;
  AudioPlayer player = AudioPlayer();
  Duration position = const Duration();
  Duration duration = const Duration();
  bool isEditing = false;

  @override
  initState() {
    super.initState();

    player = context.read<PlayerProvider>().player.player;
    player.onPositionChanged.listen((Duration p) {
      if (isEditing) {
        return;
      }

      setState(() {
        position = p;
        _currentSliderValue = p.inSeconds.toDouble() / duration.inSeconds.toDouble() * 100;
      });
    });

    player.onDurationChanged.listen((Duration d) {
      setState(() => duration = d);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.amber.withOpacity(0),
              child: Text(formatDuration(position)),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(0),
                child: Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 100,
                  onChangeStart: (value) => setState(() => isEditing = true),
                  onChangeEnd: (value) async {
                    var d = Duration(seconds: ((value / 100) * duration.inSeconds).toInt());
                    await player.seek(d);

                    setState(() {
                      isEditing = false;
                    });
                  },
                  onChanged: (double value) async {
                    setState(() => _currentSliderValue = value);

                    var d = Duration(seconds: ((value / 100) * duration.inSeconds).toInt());

                    setState(() {
                      position = d;
                    });
                  },
                ),
              ),
            ),
            Text(formatDuration(duration)),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
