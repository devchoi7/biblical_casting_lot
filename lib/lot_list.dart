import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'lot_select.dart';
import 'main.dart';
import 'past_list.dart';
import 'riverpod_def.dart';
import 'settings.dart';

class LotList extends ConsumerStatefulWidget {
  const LotList({Key? key}) : super(key: key);

  @override
  ConsumerState<LotList> createState() => _LotListState();
}

class _LotListState extends ConsumerState<LotList> {
  final lotTitle = TextEditingController();
  final lotItem = TextEditingController();
  final lotNum = TextEditingController();
  final lotItemFocusNode = FocusNode();
  bool? deleteLists;

  @override
  void initState() {
    deleteLists = false;
    super.initState();
  }

  Future<void> _dialogBuilder1(BuildContext context) {
    final lotItemsList = ref.watch(lotItemsListProvider);
    final lotTitleList = ref.watch(lotTitleListProvider);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return (lotItemsList.isEmpty && lotTitleList.isEmpty)
            ? AlertDialog(
                title: const LocaleText('delete_all'),
                content: const LocaleText(
                  'nothing_to_delete',
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const LocaleText('ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: const LocaleText('delete_all'),
                content: const LocaleText(
                  'delete_all_confirm',
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const LocaleText('yes'),
                    onPressed: () {
                      lotTitleList.clear();
                      lotItemsList.clear();
                      setState(() {
                        deleteLists == false
                            ? deleteLists = true
                            : deleteLists = false;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const LocaleText('no'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
      },
    );
  }

  Future<void> _dialogBuilder2(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const LocaleText('title_items'),
          content: const LocaleText(
            'min_items',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const LocaleText('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    lotTitle;
    lotItem;
    lotNum;
    lotItemFocusNode;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lotItemsList = ref.watch(lotItemsListProvider);
    final lotTitleList = ref.watch(lotTitleListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(
          'title_items',
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
            onPressed: () => _dialogBuilder1(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    lotTitleList.isEmpty
                        ? const LocaleText(
                            'casting_lots_title',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )
                        : Text(
                            '* ${lotTitleList[0]} *',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                    const SizedBox(height: 10),
                    lotItemsList.isEmpty
                        ? const LocaleText(
                            'casting_lots_items',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: lotItemsList.length,
                            itemBuilder: (buildContext, index) {
                              return Text(
                                '   ${index + 1} - ${lotItemsList[index]}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              );
                            },
                          ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Settings(),
                          ),
                        );
                      },
                      child: const LocaleText(
                        'select_lot_type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        (lotItemsList.length < 2)
                            ? _dialogBuilder2(context)
                            : (
                                ref
                                    .read(lotItemsList2Provider.notifier)
                                    .update((state) => lotItemsList.toList()),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LotSelect(),
                                  ),
                                )
                              );
                      },
                      child: const LocaleText(
                        'start',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: lotTitle,
                            decoration: InputDecoration(
                              labelText: context.localeString('input_title'),
                              hintText:
                                  context.localeString('input_title_hint'),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            lotTitle.text.trim() == ''
                                ? null
                                : setState(() {
                                    lotTitleList.clear();
                                    lotTitleList.add(lotTitle.text);
                                    lotTitle.text = '';
                                  });
                          },
                          child: const LocaleText('add'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: lotItem,
                            focusNode: lotItemFocusNode,
                            decoration: InputDecoration(
                              labelText: context.localeString('input_item'),
                              hintText: context.localeString('min2_max12'),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            lotItem.text.trim() == ''
                                ? null
                                : setState(() {
                                    (lotItemsList.length >= 12)
                                        ? null
                                        : lotItemsList.add(lotItem.text);
                                    lotItem.text = '';
                                  });
                          },
                          child: const LocaleText('add'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: lotNum,
                            decoration: InputDecoration(
                              labelText: context.localeString('change_item'),
                              hintText: context.localeString('input_item_num'),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                var lot = int.tryParse(lotNum.text);
                                (lotNum.text.trim() == '' ||
                                        lot == null ||
                                        !(lot % 1 == 0) ||
                                        lotItemsList.isEmpty ||
                                        lot > lotItemsList.length)
                                    ? null
                                    : setState(() {
                                        lotItem.text = lotItemsList[lot - 1];
                                        lotItemsList.removeAt(lot - 1);
                                        lotNum.text = '';
                                        lotItemFocusNode.requestFocus();
                                      });
                              },
                              child: const LocaleText('change'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                var lot = int.tryParse(lotNum.text);
                                (lotNum.text.trim() == '' ||
                                        lot == null ||
                                        !(lot % 1 == 0) ||
                                        lotItemsList.isEmpty ||
                                        lot > lotItemsList.length)
                                    ? null
                                    : setState(() {
                                        lotItemsList.removeAt(lot - 1);
                                        lotNum.text = '';
                                        lotItemFocusNode.requestFocus();
                                      });
                              },
                              child: const LocaleText('delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
