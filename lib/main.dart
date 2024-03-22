import 'dart:io';
import 'package:cisum/menus.dart';
import 'package:cisum/provider/player.dart';
import 'package:cisum/views/database/database.dart';
import 'package:cisum/views/playing/playing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

setWindow() async {
// 必须加上这一行。
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(350, 600),
    minimumSize: Size(350, 300),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isMacOS) {
    setWindow();
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return getApp();
    }

    return PlatformMenuBar(
      menus: menus,
      child: getApp(),
    );
  }

  getApp() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(), // 设置亮色主题
        darkTheme: ThemeData.dark(), // 设置暗色主题
        themeMode: ThemeMode.system,
        home: Scaffold(
          appBar: const PreferredSize(preferredSize: Size(100, 190), child: Playing()),
          body: Container(
            color: Colors.redAccent.withOpacity(0),
            child: const Database(),
          ),
        ),
      ),
    );
  }
}
