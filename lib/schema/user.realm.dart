// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends _User with RealmEntity, RealmObjectBase, RealmObject {
  User(
    String mobile,
    String name,
    String initials,
    String providerName,
    int providerID,
  ) {
    RealmObjectBase.set(this, 'mobile', mobile);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'initials', initials);
    RealmObjectBase.set(this, 'providerName', providerName);
    RealmObjectBase.set(this, 'providerID', providerID);
  }

  User._();

  @override
  String get mobile => RealmObjectBase.get<String>(this, 'mobile') as String;
  @override
  set mobile(String value) => RealmObjectBase.set(this, 'mobile', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get initials =>
      RealmObjectBase.get<String>(this, 'initials') as String;
  @override
  set initials(String value) => RealmObjectBase.set(this, 'initials', value);

  @override
  String get providerName =>
      RealmObjectBase.get<String>(this, 'providerName') as String;
  @override
  set providerName(String value) =>
      RealmObjectBase.set(this, 'providerName', value);

  @override
  int get providerID => RealmObjectBase.get<int>(this, 'providerID') as int;
  @override
  set providerID(int value) => RealmObjectBase.set(this, 'providerID', value);

  @override
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObjectBase.getChanges<User>(this);

  @override
  Stream<RealmObjectChanges<User>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<User>(this, keyPaths);

  @override
  User freeze() => RealmObjectBase.freezeObject<User>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'mobile': mobile.toEJson(),
      'name': name.toEJson(),
      'initials': initials.toEJson(),
      'providerName': providerName.toEJson(),
      'providerID': providerID.toEJson(),
    };
  }

  static EJsonValue _toEJson(User value) => value.toEJson();
  static User _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'mobile': EJsonValue mobile,
        'name': EJsonValue name,
        'initials': EJsonValue initials,
        'providerName': EJsonValue providerName,
        'providerID': EJsonValue providerID,
      } =>
        User(
          fromEJson(mobile),
          fromEJson(name),
          fromEJson(initials),
          fromEJson(providerName),
          fromEJson(providerID),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(User._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, User, 'User', [
      SchemaProperty('mobile', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('initials', RealmPropertyType.string),
      SchemaProperty('providerName', RealmPropertyType.string),
      SchemaProperty('providerID', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
