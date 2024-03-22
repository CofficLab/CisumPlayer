import 'package:cisum/entities/database.dart';
import 'package:cisum/entities/logger.dart';
import 'package:cisum/entities/playlist.dart';
import 'package:cisum/provider/player.dart';
import 'package:cisum/views/database/database_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class Database extends StatefulWidget {
  const Database({super.key});

  @override
  State<Database> createState() => _DatabaseState();
}

class _DatabaseState extends State<Database> {
  PlaylistModel playlist = PlaylistModel.emptyPlayList;

  @override
  void initState() {
    super.initState();
    refreshPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      // Formats this region can accept.
      formats: Formats.standardFormats,
      hitTestBehavior: HitTestBehavior.opaque,
      onDropOver: (event) {
        debugPrint("onDropOver");
        // You can inspect local data here, as well as formats of each item.
        // However on certain platforms (mobile / web) the actual data is
        // only available when the drop is accepted (onPerformDrop).
        final item = event.session.items.first;
        if (item.localData is Map) {
          // This is a drag within the app and has custom local data set.
        }
        if (item.canProvide(Formats.plainText)) {
          // this item contains plain text.
          debugPrint("item contains plain text");
        }
        // This drop region only supports copy operation.
        if (event.session.allowedOperations.contains(DropOperation.copy)) {
          return DropOperation.copy;
        } else {
          return DropOperation.none;
        }
      },
      onDropEnter: (event) {
        debugPrint("onDropEnter");
        // This is called when region first accepts a drag. You can use this
        // to display a visual indicator that the drop is allowed.
      },
      onDropLeave: (event) {
        logger.d("onDropLeave");
        // Called when drag leaves the region. Will also be called after
        // drag completion.
        // This is a good place to remove any visual indicators.
        refreshPlaylist();
      },
      onPerformDrop: (event) async {
        debugPrint("onPerformDrop");
        // Called when user dropped the item. You can now request the data.
        // Note that data must be requested before the performDrop callback
        // is over.
        final item = event.session.items.first;
        await DatabaseModel.saveFile(item.dataReader!);
      },
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DatabaseTable(
            playlist: playlist,
          )),
    );
  }

  refreshPlaylist() {
    logger.d("DatabaseTable::refreshPlaylist");
    DatabaseModel.getPlaylist().then((value) {
      playlist = value;
      context.read<PlayerProvider>().player.setPlaylist(value);
      setState(() {});
    });
  }
}
