import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'riverpod_def.g.dart';

final prefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final listNameIndexProvider = StateProvider<int>((ref) {
  final prefs = ref.watch(prefsProvider);
  final listNameIndex = prefs.getInt('listNameIndex') ?? 5;
  ref.listenSelf((previous, next) {
    prefs.setInt('listNameIndex', next);
  });
  return listNameIndex;
});

// @riverpod
// List<String> lotTitleList(LotTitleListRef ref) {
//   return [];
// }

final lotTitleListProvider = StateProvider<List<String>>(
  (ref) {
    final prefs = ref.watch(prefsProvider);
    final lotTitleList = prefs.getStringList('lotTitleList') ?? [];
    ref.listenSelf((previous, next) {
      prefs.setStringList('lotTitleList', next);
    });
    return lotTitleList;
  },
);

// @riverpod
// List<String> lotItemsList(LotItemsListRef ref) {
//   return [];
// }

final lotItemsListProvider = StateProvider<List<String>>(
  (ref) {
    final prefs = ref.watch(prefsProvider);
    final lotItemsList = prefs.getStringList('lotItemsList') ?? [];
    ref.listenSelf((previous, next) {
      prefs.setStringList('lotItemsList', next);
    });
    return lotItemsList;
  },
);

final lotItemsList2Provider = StateProvider<List<String>>(
  (ref) {
    final prefs = ref.watch(prefsProvider);
    final lotItemsList2 = prefs.getStringList('lotItemsList2') ?? [];
    ref.listenSelf((previous, next) {
      prefs.setStringList('lotItemsList2', next);
    });
    return lotItemsList2;
  },
);

// @riverpod
// List<String> selectedItems(SelectedItemsRef ref) {
//   return [];
// }

final selectedItemsProvider = StateProvider<List<String>>(
  (ref) {
    final prefs = ref.watch(prefsProvider);
    final selectedItems = prefs.getStringList('selectedItems') ?? [];
    ref.listenSelf((previous, next) {
      prefs.setStringList('selectedItems', next);
    });
    return selectedItems;
  },
);

// @riverpod
// List<Map<String, dynamic>> lotResultRecord(LotResultRecordRef ref) {
//   return [];
// }

@HiveType(typeId: 1)
class LotResultRecord extends HiveObject {
  LotResultRecord({
    required this.date,
    required this.time,
    required this.title,
    required this.items,
    required this.selected,
  });

  @HiveField(0)
  String date;

  @HiveField(1)
  String time;

  @HiveField(2)
  String title;

  @HiveField(3)
  String items;

  @HiveField(4)
  String selected;

  @override
  String toString() {
    return '{date: $date, time: $time, title: $title, items: $items, selected: $selected}';
  }

  factory LotResultRecord.fromJson(Map<String, dynamic> json) {
    return LotResultRecord(
      date: json['date'],
      time: json['time'],
      title: json['title'],
      items: json['items'].toString(),
      selected: json['selected'].toString(),
    );
  }
}
