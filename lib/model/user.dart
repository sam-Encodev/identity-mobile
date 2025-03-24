import 'package:realm/realm.dart';
import 'package:identity/schema/user.dart';
import 'package:identity/constants/data.dart';
import 'package:identity/constants/transformer.dart';
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

  writeUser(info) {
    var providerName = getbankCode(info[accountNumber]);
    var initials = grabInitials(info[accountName]);

    final user = User(
      info[accountNumber],
      info[accountName],
      initials,
      providerName,
      info[bankId],
    );

    realm.write(() {
      realm.add(user);
      realm.refresh();
    });

    return user;
  }

  writeBulk() {
    var users = dummyData;
    realm.write(() {
      realm.addAll(users);
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
