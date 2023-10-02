import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'lot_list.dart';
import 'lots.dart';
import 'main.dart';
import 'past_list.dart';
import 'riverpod_def.dart';
import 'settings.dart';

class LotSelect extends ConsumerStatefulWidget {
  const LotSelect({Key? key}) : super(key: key);

  @override
  ConsumerState<LotSelect> createState() => _LotSelectState();
}

class _LotSelectState extends ConsumerState<LotSelect> {
  bool? mixLots;
  final now = DateTime.now();
  InterstitialAd? interstitialAd;
  final adUnitId = 'ca-app-pub-3940256099942544/1033173712';
  // test value: 'ca-app-pub-3940256099942544/1033173712'

  @override
  void initState() {
    mixLots = false;
    loadAd();
    super.initState();
  }

  void loadAd() {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdClicked: (ad) {},
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PastList(),
                ),
              );
            },
          );
          // debugPrint('$ad loaded');
          interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          // debugPrint('InterstitialAd failed to load: $err');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lotTitleList = ref.watch(lotTitleListProvider);
    final lotItemsList = ref.watch(lotItemsListProvider);
    final lotItemsList2 = ref.watch(lotItemsList2Provider);
    final listNameIndex = ref.watch(listNameIndexProvider);
    final selectedItems = ref.watch(selectedItemsProvider);

    int lotNum = lotItemsList.length;

    Future<void> lotResult1(BuildContext context, int index) {
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const LocaleText('lot_result'),
            content: Text(
              lotItemsList[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const LocaleText('ok'),
                onPressed: () {
                  setState(() {
                    selectedItems.add(lotItemsList[index]);
                    var lotResultRecord = LotResultRecord(
                      date: '${now.year}-${now.month}-${now.day}',
                      time: (now.hour < 13)
                          ? '${context.localeString('am')} ${now.hour}:${now.minute}:${now.second}'
                          : '${context.localeString('pm')} ${now.hour - 12}:${now.minute}:${now.second}',
                      title: lotTitleList.isEmpty
                          ? context.localeString('no_title')
                          : lotTitleList[0],
                      items: lotItemsList2
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', ''),
                      selected: selectedItems
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', ''),
                    );
                    box.add(lotResultRecord);
                    lotTitleList.clear();
                    lotItemsList.clear();
                    selectedItems.clear();
                  });
                  Navigator.pop(context);
                  if (interstitialAd != null) {
                    interstitialAd?.show();
                  } else {
                    interstitialAd?.dispose();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PastList(),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> lotResult2(BuildContext context, int index) {
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const LocaleText('lot_result'),
            content: Text(
              lotItemsList[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const LocaleText('cast_remaining'),
                onPressed: () {
                  setState(() {
                    selectedItems.add(lotItemsList[index]);
                    lotItemsList.removeAt(index);
                  });
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const LocaleText('ok'),
                onPressed: () {
                  setState(() {
                    selectedItems.add(lotItemsList[index]);
                    var lotResultRecord = LotResultRecord(
                      date: '${now.year}-${now.month}-${now.day}',
                      time: (now.hour < 13)
                          ? "${context.localeString('am')} ${now.hour}:${now.minute}:${now.second}"
                          : "${context.localeString('pm')} ${now.hour - 12}:${now.minute}:${now.second}",
                      title: lotTitleList.isEmpty
                          ? context.localeString('no_title')
                          : lotTitleList[0],
                      items: lotItemsList2
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', ''),
                      selected: selectedItems
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', ''),
                    );
                    box.add(lotResultRecord);
                    lotTitleList.clear();
                    lotItemsList.clear();
                    selectedItems.clear();
                  });
                  Navigator.pop(context);
                  if (interstitialAd != null) {
                    interstitialAd?.show();
                  } else {
                    interstitialAd?.dispose();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PastList(),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }

    List<Widget> positionedImages = List.generate(lotNum, (index) {
      var img = listNamesEn[listNameIndex][index];
      var r = Random();
      var screenWidth = MediaQuery.of(context).size.width.toInt();
      var screenHeight = MediaQuery.of(context).size.height.toInt();

      var randomX = r.nextInt(screenWidth - 120).toDouble();
      var randomY = r.nextInt(screenHeight - 220).toDouble();

      return Positioned(
        top: randomY,
        left: randomX,
        child: GestureDetector(
          onTap: () => (lotItemsList.length == 2)
              ? lotResult1(context, index)
              : lotResult2(context, index),
          child: Image.asset(img, width: 100, height: 100),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LotList(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const LocaleText(
          'casting_lots',
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
            tooltip: context.localeString('select_lot_type'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            tooltip: context.localeString('shuffle'),
            onPressed: () {
              setState(() {
                mixLots == false ? mixLots = true : mixLots = false;
              });
            },
            icon: const Icon(Icons.replay),
          ),
        ],
      ),
      body: lotItemsList.length >= 2
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  ...positionedImages,
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LocaleText(
                    'no_item',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LotList(),
                        ),
                      );
                    },
                    child: const LocaleText(
                      'go_input_item',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(),
                        ),
                      );
                    },
                    child: const LocaleText(
                      'go_to_home_screen',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
