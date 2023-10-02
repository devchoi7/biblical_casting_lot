import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:permission_handler/permission_handler.dart';

import 'lot_list.dart';
import 'main.dart';
import 'past_list.dart';

class Backup extends StatefulWidget {
  const Backup({Key? key}) : super(key: key);

  @override
  State<Backup> createState() => _BackupState();
}

class _BackupState extends State<Backup> {
  Future<void> createBackup() async {
    if (box.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: LocaleText('no_history_2')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: LocaleText('making_backup')),
    );
    String lotResultRecord = box
        .toMap()
        .values
        .toList()
        .reversed
        .toList()
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('}, ', '\n\n')
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('date', context.localeString('date'))
        .replaceAll(', time', context.localeString('time'))
        .replaceAll(', title', context.localeString('title'))
        .replaceAll(', items', context.localeString('items'))
        .replaceAll(', selected', context.localeString('selected'));
    await Permission.storage.request();
    Directory dir = await _getDirectory();
    String formattedDate = DateTime.now()
        .toString()
        .replaceAll('.', '-')
        .replaceAll(' ', '-')
        .replaceAll(':', '-');
    //Change .json to your desired file format(like .barbackup or .hive or .txt)
    String path = '${dir.path}$formattedDate.txt';
    File backupFile = File(path);
    await backupFile.writeAsString(lotResultRecord);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: LocaleText('saved')),
    );
  }

  Future<Directory> _getDirectory() async {
    // This is the name of the folder where the backup is stored
    String pathExt = context.localeString('history_folder');
    //Change this to any desired location where the folder will be created
    Directory newDirectory = Directory('/storage/emulated/0/$pathExt');
    if (await newDirectory.exists() == false) {
      return newDirectory.create(recursive: true);
    }
    return newDirectory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(
          'backup',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 10,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
            },
            icon: const Icon(Icons.home),
          ),
          IconButton(
            tooltip: context.localeString('past_history'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PastList(),
                ),
              );
            },
            icon: const Icon(Icons.history),
          ),
          IconButton(
            tooltip: context.localeString('title_item_setting'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LotList(),
                ),
              );
            },
            icon: const Icon(Icons.list_alt),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LocaleText(
                'backup_info',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              ElevatedButton(
                onPressed: () => createBackup(),
                child: const LocaleText(
                  'history_backup',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
