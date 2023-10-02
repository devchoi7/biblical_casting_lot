import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'lot_list.dart';
import 'lot_select.dart';
import 'lots.dart';
import 'riverpod_def.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(
          'settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 10,
        actions: [
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
          IconButton(
            tooltip: context.localeString('casting_lots'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LotSelect(),
                ),
              );
            },
            icon: const Icon(Icons.check_circle_outline),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: listNamesKr.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (context.currentLocale.toString() == 'en')
                        ? listNamesEn2[index]
                        : listNamesKr[index],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(listNameIndexProvider.notifier)
                          .update((state) => index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LotSelect(),
                        ),
                      );
                    },
                    child: const LocaleText('select'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(listNamesEn[index][0], width: 40, height: 40),
                    Image.asset(listNamesEn[index][1], width: 40, height: 40),
                    Image.asset(listNamesEn[index][2], width: 40, height: 40),
                    Image.asset(listNamesEn[index][3], width: 40, height: 40),
                    Image.asset(listNamesEn[index][4], width: 40, height: 40),
                    Image.asset(listNamesEn[index][5], width: 40, height: 40),
                    Image.asset(listNamesEn[index][6], width: 40, height: 40),
                    Image.asset(listNamesEn[index][7], width: 40, height: 40),
                    Image.asset(listNamesEn[index][8], width: 40, height: 40),
                    Image.asset(listNamesEn[index][9], width: 40, height: 40),
                    Image.asset(listNamesEn[index][10], width: 40, height: 40),
                    Image.asset(listNamesEn[index][11], width: 40, height: 40),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
