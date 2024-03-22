import 'package:path/path.dart' as path;
import 'package:audioplayers/audioplayers.dart';

class AudioAction {
  static getTitle(String filePath) {
    String title = path.basename(filePath);
    String extension = path.extension(filePath);
    title = title.replaceAll(extension, "");
    return title;
  }

  static play(String filePath) async {
    final player = AudioPlayer();
    await player.play(DeviceFileSource(filePath));
  }
}
