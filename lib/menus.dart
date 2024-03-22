import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';

var menus = [
  const PlatformMenu(
    label: 'macos_ui Widget Gallery',
    menus: [
      PlatformProvidedMenuItem(
        type: PlatformProvidedMenuItemType.about,
      ),
      PlatformProvidedMenuItem(
        type: PlatformProvidedMenuItemType.quit,
      ),
    ],
  ),
  const PlatformMenu(
    label: '显示',
    menus: [
      PlatformProvidedMenuItem(
        type: PlatformProvidedMenuItemType.toggleFullScreen,
      ),
    ],
  ),
  const PlatformMenu(
    label: '窗口',
    menus: [
      PlatformProvidedMenuItem(
        type: PlatformProvidedMenuItemType.minimizeWindow,
      ),
      PlatformProvidedMenuItem(
        type: PlatformProvidedMenuItemType.zoomWindow,
      ),
    ],
  ),
  PlatformMenu(
    label: '调试',
    menus: [
      PlatformMenuItem(
          label: '打开APP文档目录',
          onSelected: () async {
            var path = await getApplicationDocumentsDirectory();
            Process.run('open', [path.path]);
          }),
    ],
  ),
];
