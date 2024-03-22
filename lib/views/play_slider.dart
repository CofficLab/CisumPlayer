import 'package:audioplayers/audioplayers.dart';
import 'package:cisum/entities/logger.dart';
import 'package:cisum/provider/player.dart';
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
        // logger.d("position: $position, _currentSliderValue: $_currentSliderValue");
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
                // color: Colors.blueAccent,
                child: Slider(
                  // divisions: 10,
                  // secondaryActiveColor: Colors.indigo,
                  // thumbColor: Colors.red,
                  // overlayColor: MaterialStateProperty.all(Colors.red),
                  // activeColor: Colors.yellowAccent,
                  value: _currentSliderValue,
                  min: 0,
                  max: 100,
                  onChangeStart: (value) => setState(() => isEditing = true),
                  onChangeEnd: (value) async {
                    var d = Duration(seconds: ((value / 100) * duration.inSeconds).toInt());
                    logger.d("onChangeEnd: ${d.toString()}");
                    logger.d("goto: $d");
                    await player.seek(d);

                    setState(() {
                      isEditing = false;
                    });
                  },
                  onChanged: (double value) async {
                    logger.d("onChanged: $value");
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
