import 'package:realm/realm.dart';
import 'package:identity/schema/user.dart';
import 'package:identity/constants/data.dart';
import 'package:identity/constants/transformer.dart';

class UserModel {
  late Realm realm;

  UserModel() {
    var config = Configuration.local(
      [User.schema],
      // schemaVersion: 3,
      // // delete table
      // migrationCallback: (migration, oldSchemaVersion) {
      //   migration.deleteType('User');
      // },
    );
    realm = Realm(config);
  }

  findUser(mobile) {
    try {
      var user = realm.query<User>("mobile == '$mobile'").first;
      return (user: user, message: true);
    } catch (e) {
      return (user: User, message: false);
    }
  }

  writeUser(info) {
    var providerName = getbankCode(info["account_number"]);
    // var initials = grabInitials(info["account_name"]);

    final user = User(
      info["account_number"],
      info["account_name"],
      // initials,
      providerName,
      info["bank_id"],
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
