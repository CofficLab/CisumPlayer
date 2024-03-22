import 'package:cisum/entities/logger.dart';
import 'package:flutter/services.dart';

class MessageChannel {
  final MethodChannel ch = const MethodChannel('app/message');

  Future<String> createData() async {
    String result = await ch.invokeMethod('create');
    logger.d(result);
    return result;
  }
}
