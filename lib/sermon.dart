import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:url_launcher/url_launcher.dart';

import 'lot_list.dart';
import 'main.dart';

class Sermon extends StatelessWidget {
  const Sermon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LocaleText(
          'sermon',
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
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: '',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: context.localeString('thanks'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            (context.currentLocale.toString() == 'en')
                                ? launchUrl(Uri.parse(
                                    'https://www.desiringgod.org/messages/the-sovereignty-of-god-my-counsel-shall-stand-and-i-will-accomplish-all-my-purpose/excerpts/what-kind-of-jesus-do-you-worship'))
                                : launchUrl(Uri.parse(
                                    'https://www.youtube.com/@GODWARD_YT'));
                          },
                      ),
                      TextSpan(
                        text: context.localeString('estimated'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: context.localeString('almighty'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 30,
                        ),
                      ),
                      TextSpan(
                        text: context.localeString('piper'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: context.localeString('sermon_text'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const LocaleText(
                'start',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LotList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
