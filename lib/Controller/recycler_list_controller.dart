import 'package:flutter/material.dart';
import 'package:loginfirebase/Models/list_item.dart';
import 'package:realm/realm.dart';

class RecyclerListController extends ChangeNotifier {
  List<Item> persons = [];

  realmAdd() {
    print('realmAdded');
    var config = Configuration.local([Item.schema]);
    var realm = Realm(config);

    realm.write(
      () {
        realm.deleteAll<Item>();
        realm.add(Item('cName', 19, 'dcity'));
        realm.add(Item('dName', 25, 'acity'));
        realm.add(Item('bName', 36, 'ccity'));
        realm.add(Item('aName', 42, 'bcity'));
      },
    );

    var people = realm.all<Item>();
    persons = people
        .map((e) => Item(
              e.name,
              e.age,
              e.city,
            ))
        .toList();
    notifyListeners();
  }

  realmSort(String sortBy) {
    var config = Configuration.local([Item.schema]);
    var realm = Realm(config);
    realm.write(() {
      final sorted = realm.query<Item>('TRUEPREDICATE SORT($sortBy ASC)');
      persons.clear();
      for (var e in sorted) persons.add(Item(e.name, e.age, e.city));
    });
    notifyListeners();
  }
}

class SortyBy {
  static const name = 'name';
  static const age = 'age';
  static const city = 'city';
}
