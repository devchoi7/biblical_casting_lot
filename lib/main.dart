import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lot_list.dart';
import 'past_list.dart';
import 'prepare.dart';
import 'riverpod_def.dart';
import 'user_guide.dart';

late Box box;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'ko']); // with await: get last saved language
  // remove await, if you want to get app default language -> [0] or ['en']
  MobileAds.instance.initialize();
  final prefs = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  Hive.registerAdapter(LotResultRecordAdapter());
  box = await Hive.openBox('lotResultRecords');

  runApp(
    ProviderScope(
      overrides: [
        prefsProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Biblical Casting Lots',
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String currentLanguage = context.currentLocale.toString();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const LocaleText(
          'main_title',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 10,
        actions: [
          DropdownButton(
            value: currentLanguage,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 20,
            items: [
              DropdownMenuItem(
                value: 'en',
                child: Text(
                  (context.currentLocale.toString() == 'en')
                      ? '🇺🇸 eng'
                      : '🇺🇸 영어',
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () => context.changeLocale('en'),
              ),
              DropdownMenuItem(
                value: 'ko',
                child: Text(
                  (context.currentLocale.toString() == 'en')
                      ? '🇰🇷 kor'
                      : '🇰🇷 한글',
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () => context.changeLocale('ko'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                currentLanguage = value!;
              });
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const LocaleText(
                  'pr16_33',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserGuide(),
                    ),
                  );
                },
                child: const LocaleText(
                  'user_guide',
                  style: TextStyle(
                    fontSize: 20,
                    // color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Prepare(),
                    ),
                  );
                },
                child: const LocaleText(
                  'mindset',
                  style: TextStyle(
                    fontSize: 20,
                    // color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PastList(),
                    ),
                  );
                },
                child: const LocaleText(
                  'past history',
                  style: TextStyle(
                    fontSize: 20,
                    // color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                    // color: Colors.blue,
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
