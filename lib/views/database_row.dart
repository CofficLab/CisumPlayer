import 'package:cisum/entities/audio.dart';
import 'package:flutter/material.dart';
import 'package:super_context_menu/super_context_menu.dart';

class DatabaseRow extends StatelessWidget {
  const DatabaseRow({super.key});

  @override
  Widget build(BuildContext context) {
    return ContextMenuWidget(
      child: Text('Base Context Menu'),
      menuProvider: (_) {
        return Menu(
          children: [
            MenuAction(title: 'Menu Item 2', callback: () {}),
            MenuAction(title: 'Menu Item 3', callback: () {}),
            MenuSeparator(),
            Menu(title: 'Submenu', children: [
              MenuAction(title: 'Submenu Item 1', callback: () {}),
              MenuAction(title: 'Submenu Item 2', callback: () {}),
              Menu(title: 'Nested Submenu', children: [
                MenuAction(title: 'Submenu Item 1', callback: () {}),
                MenuAction(title: 'Submenu Item 2', callback: () {}),
              ]),
            ]),
          ],
        );
      },
    );
  }
}
