import 'package:realm/realm.dart';
import 'package:identity/schema/user.dart';
import 'package:identity/constants/data.dart';
import 'package:identity/constants/text.dart';

class UserModel {
  late Realm realm;

  UserModel() {
    var config = Configuration.local(
      [User.schema],
      schemaVersion: 0,
      // delete table
      migrationCallback: (migration, oldSchemaVersion) {
        migration.deleteType(user);
      },
    );
    realm = Realm(config);
    // realm.close();
  }

  findUser(mobile) {
    var user = realm.query<User>("mobile == '$mobile'");

    if (user.isNotEmpty) {
      return (user: user.first, message: true);
    }

    return (user: User, message: false);
  }

  writeUser(user) {
    realm.write(() {
      realm.add(user);
      realm.refresh();
    });
  }

  writeUsers() {
    realm.write(() {
      realm.addAll(dummyData);
      realm.refresh();
    });
  }

  deleteUser(mobile) {
    final user = realm.query<User>("mobile == '$mobile'").first;
    realm.write(() {
      realm.delete(user);
      realm.refresh();
    });
  }

  getUsers() {
    realm.refresh();
    return realm.all<User>();
  }

  clearDB() {
    realm.write(() {
      realm.deleteAll<User>();
      realm.refresh();
    });
  }
}
