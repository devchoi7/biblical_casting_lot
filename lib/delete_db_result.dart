import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'lot_list.dart';
import 'main.dart';
import 'past_list.dart';

class DeleteDbResult extends StatefulWidget {
  const DeleteDbResult({Key? key}) : super(key: key);

  @override
  State<DeleteDbResult> createState() => _DeleteDbResultState();
}

class _DeleteDbResultState extends State<DeleteDbResult> {
  Future<void> _dialogBuilder() {
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PastList(),
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PastList(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const LocaleText(
            'confirm_delete',
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
            IconButton(
              tooltip: context.localeString('quit_app'),
              onPressed: () => _dialogBuilder(),
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LocaleText(
                'history_deleted',
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
        ),
      ),
    );
  }
}
