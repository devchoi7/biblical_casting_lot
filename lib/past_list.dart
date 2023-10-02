import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'backup.dart';
import 'delete_db_result.dart';
import 'lot_list.dart';
import 'main.dart';
import 'riverpod_def.dart';

class PastList extends ConsumerStatefulWidget {
  const PastList({Key? key}) : super(key: key);

  @override
  ConsumerState<PastList> createState() => _PastListState();
}

class _PastListState extends ConsumerState<PastList> {
  BannerAd? anchoredAdaptiveAd;
  bool isLoaded = false;
  final adUnitId = 'ca-app-pub-3940256099942544/6300978111';
  // test value: 'ca-app-pub-3940256099942544/6300978111'

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadAd();
  }

  Future<void> loadAd() async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      return;
    }

    anchoredAdaptiveAd = BannerAd(
      adUnitId: adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          // debugPrint('$ad loaded: ${ad.responseInfo}');
          setState(() {
            anchoredAdaptiveAd = ad as BannerAd;
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // debugPrint('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return anchoredAdaptiveAd!.load();
  }

  Future<void> _dialogBuilder1() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const LocaleText('delete_history_1'),
          content: const LocaleText(
            'no_history_1',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const LocaleText('ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogBuilder2() {
    final selectedItems = ref.watch(selectedItemsProvider);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const LocaleText('delete_history_1'),
          content: const LocaleText(
            'delete_confirm',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const LocaleText('yes'),
              onPressed: () {
                setState(() {
                  box.clear();
                  selectedItems.clear();
                });
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeleteDbResult(),
                  ),
                );
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const LocaleText('no'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogBuilder3() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const LocaleText('quit_app'),
          content: const LocaleText(
            'quit_app_confirm',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const LocaleText('yes'),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const LocaleText('no'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const LocaleText(
          'past_history',
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
            tooltip: context.localeString('delete_history_2'),
            onPressed: () =>
                box.isEmpty ? _dialogBuilder1() : _dialogBuilder2(),
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            tooltip: context.localeString('save_history'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Backup(),
                ),
              );
            },
            icon: const Icon(Icons.save),
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
          IconButton(
            tooltip: context.localeString('quit_app'),
            onPressed: () => _dialogBuilder3(),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: box.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LocaleText(
                    'no_past_history',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Column(
                    children: [
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
                          'start',
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
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LocaleText(
                            'recent_result',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const LocaleText(
                              //   'history_title',
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              Text(
                                '${box.getAt(box.length - 1).title}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Wrap(
                                children: [
                                  const LocaleText(
                                    'history_datetime',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${box.getAt(box.length - 1).date}, ${box.getAt(box.length - 1).time}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                              Wrap(
                                children: [
                                  const LocaleText(
                                    'history_all_items',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${box.getAt(box.length - 1).items}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Wrap(
                                children: [
                                  const LocaleText(
                                    'history_selected_items',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${box.getAt(box.length - 1).selected}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const LocaleText(
                            'past_results',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 15),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            reverse: true,
                            itemCount: box.length - 1,
                            itemBuilder: ((context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const LocaleText(
                                  //   'history_title',
                                  //   style: TextStyle(
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  Text(
                                    '${box.getAt(index).title}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      const LocaleText(
                                        'history_datetime',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${box.getAt(index).date}, ${box.getAt(index).time}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      const LocaleText(
                                        'history_all_items',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${box.getAt(index).items}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      const LocaleText(
                                        'history_selected_items',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${box.getAt(index).selected}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (anchoredAdaptiveAd != null && isLoaded)
                  Container(
                    color: Colors.green,
                    width: anchoredAdaptiveAd!.size.width.toDouble(),
                    height: anchoredAdaptiveAd!.size.height.toDouble(),
                    child: AdWidget(ad: anchoredAdaptiveAd!),
                  )
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    anchoredAdaptiveAd?.dispose();
  }
}
