// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_item.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Item extends _Item with RealmEntity, RealmObject {
  Item(
    String name,
    int age,
    String city,
  ) {
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'age', age);
    RealmObject.set(this, 'city', city);
  }

  Item._();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  int get age => RealmObject.get<int>(this, 'age') as int;
  @override
  set age(int value) => RealmObject.set(this, 'age', value);

  @override
  String get city => RealmObject.get<String>(this, 'city') as String;
  @override
  set city(String value) => RealmObject.set(this, 'city', value);

  @override
  Stream<RealmObjectChanges<Item>> get changes =>
      RealmObject.getChanges<Item>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Item._);
    return const SchemaObject(Item, 'Item', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('age', RealmPropertyType.int),
      SchemaProperty('city', RealmPropertyType.string),
    ]);
  }
}
