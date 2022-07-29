import 'package:realm/realm.dart';

part 'list_item.g.dart';

@RealmModel()
class _Item {
  late String name;

  late int age;

  late String city;
}
