import 'package:realm/realm.dart';
part 'user.realm.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  late String mobile;

  late String name;
  late String initials;
  late String providerName;
  late int providerID;
}
