// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theming.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Theming extends _Theming with RealmEntity, RealmObjectBase, RealmObject {
  Theming(
    int key,
    int value,
  ) {
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set(this, 'value', value);
  }

  Theming._();

  @override
  int get key => RealmObjectBase.get<int>(this, 'key') as int;
  @override
  set key(int value) => RealmObjectBase.set(this, 'key', value);

  @override
  int get value => RealmObjectBase.get<int>(this, 'value') as int;
  @override
  set value(int value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<Theming>> get changes =>
      RealmObjectBase.getChanges<Theming>(this);

  @override
  Stream<RealmObjectChanges<Theming>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Theming>(this, keyPaths);

  @override
  Theming freeze() => RealmObjectBase.freezeObject<Theming>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'key': key.toEJson(),
      'value': value.toEJson(),
    };
  }

  static EJsonValue _toEJson(Theming value) => value.toEJson();
  static Theming _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'key': EJsonValue key,
        'value': EJsonValue value,
      } =>
        Theming(
          fromEJson(key),
          fromEJson(value),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Theming._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Theming, 'Theming', [
      SchemaProperty('key', RealmPropertyType.int),
      SchemaProperty('value', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
