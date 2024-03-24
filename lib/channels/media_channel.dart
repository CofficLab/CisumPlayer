import 'package:coffic/entities/audio.dart';
import 'package:coffic/entities/logger.dart';
import 'package:flutter/services.dart';

class MediaChannel {
  final Function onNext;
  final Function onPrev;
  final Function onPause;
  final Function onPlay;
  final void Function(double duration) onChangePlaybackPosition;
  final MethodChannel ch = const MethodChannel('app/media');

  MediaChannel(
      {required this.onPause,
      required this.onPlay,
      required this.onPrev,
      required this.onNext,
      required this.onChangePlaybackPosition}) {
    ch.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'send':
          logger.d("MediaChannel::🐦 收到send -> ${call.arguments}");
          break;
        case 'next':
          onNext();
          break;
        case 'prev':
          onPrev();
          break;
        case 'pause':
          onPause();
          break;
        case 'play':
          logger.d("MediaChannel::🐦 收到调用 -> play");
          onPlay();
          break;
        case 'changePlaybackPositionCommand':
          logger.d("MediaChannel::🐦 收到调用 -> changePlaybackPositionCommand: ${call.arguments}");
          onChangePlaybackPosition(call.arguments);
          break;
        default:
          logger.d("MediaChannel::🐦 未知方法 -> ${call.method}");
          break;
      }
    });
  }

  setMeta({required AudioModel audio, required String state, required String current}) async {
    var meta = await audio.getMeta();
    meta.addAll(<String, String>{'state': state});
    meta.addAll(<String, String>{'current': current});
    logger.d("MediaChannel::setMeta: $meta");
    String result = await ch.invokeMethod('setMeta', meta);
    logger.d("MediaChannel::setMeta got $result");
  }
}
