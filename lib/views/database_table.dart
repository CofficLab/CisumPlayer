import 'package:cisum/entities/audio.dart';
import 'package:cisum/entities/logger.dart';
import 'package:cisum/provider/player.dart';
import 'package:cisum/provider/playlist.dart';
import 'package:cisum/views/database_cell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatabaseTable extends StatefulWidget {
  const DatabaseTable({super.key});

  @override
  State<DatabaseTable> createState() => _DatabaseTableState();
}

class _DatabaseTableState extends State<DatabaseTable> {
  @override
  Widget build(BuildContext context) {
    var playList = context.select((PlaylistProvider value) => value.playList);
    var audios = playList.audios;
    var current = context.select((PlayerProvider value) => value.getAudio());
    logger.d("构建 DataTable，audios.count = ${audios.length}, current = ${current.getTitle()}");

    return DataTable(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      horizontalMargin: 12,
      headingRowColor: MaterialStateProperty.all(Colors.black12),
      headingTextStyle: const TextStyle(fontSize: 12),
      headingRowHeight: 0,
      showCheckboxColumn: false,
      dataRowMinHeight: 24,
      dataRowMaxHeight: 24,
      dataTextStyle: const TextStyle(fontSize: 12),
      columns: const [
        DataColumn(label: Text('歌曲')),
      ],
      rows: makeRows(audios, current),
    );
  }

  onSelectedChanged(AudioModel audio) {
    context.read<PlayerProvider>().play(audio: audio);
    setState(() {});
  }

  makeRows(List<AudioModel> audios, AudioModel current) {
    return audios
        .map((audio) => DataRow(
                selected: current.sameTo(audio),
                onLongPress: () {
                  logger.d("onLongPress: ${audio.file.path}");
                },
                onSelectChanged: (value) {
                  onSelectedChanged(audio);
                },
                cells: [
                  DataCell(
                    DatabaseCell(audio: audio),
                  )
                ]))
        .toList();
  }
}
