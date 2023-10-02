import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:url_launcher/url_launcher.dart';

import 'lot_list.dart';
import 'main.dart';
import 'prayer.dart';
import 'sermon.dart';

final Uri koUrl = Uri.parse('https://www.youtube.com/watch?v=UAXJeU8r6kc');
final Uri enUrl = Uri.parse('https://www.youtube.com/watch?v=MdrpvhoJqPU');

class Prepare extends StatelessWidget {
  const Prepare({Key? key}) : super(key: key);

  Future<void> _launchKoUrl() async {
    if (!await launchUrl(koUrl)) {
      throw Exception('$koUrl을(를) 불러올 수 없습니다!');
    }
  }

  Future<void> _launchEnUrl() async {
    if (!await launchUrl(enUrl)) {
      throw Exception('Cannot load $enUrl!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localeString('mindset'),
          style: const TextStyle(
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Prayer(),
                    ),
                  );
                },
                child: const LocaleText(
                  'with_prayer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const LocaleText(
                  'piper_title',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (context.currentLocale.toString() == 'en')
                        ? _launchEnUrl
                        : _launchKoUrl,
                    child: const LocaleText(
                      'piper_video',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Sermon(),
                        ),
                      );
                    },
                    child: const LocaleText(
                      'piper_text',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
            ],
          ),
        ),
      ),
    );
  }
}
