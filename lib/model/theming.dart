import 'package:realm/realm.dart';
import 'package:identity/services/getit.dart';
import 'package:identity/schema/theming.dart';

class ThemingModel {
  late Realm realm;

  ThemingModel() {
    var config = Configuration.local(
      [Theming.schema],
      schemaVersion: 0,
      // delete table
      migrationCallback: (migration, oldSchemaVersion) {
        migration.deleteType('Theming');
      },
    );
    realm = Realm(config);
    // realm.close();
  }

  currentState(state) {
    try {
      final currentState = realm.query("key == '$state'").first;
      return currentState;
    } catch (e) {
      return currentState;
    }
  }

  writeState() {
    final themer = Theming(0, 0);
    try {
      realm.write(() {
        realm.add(themer);
      });
    } catch (e) {
      return e.toString();
    }
  }

  updateState(state) {
    try {
      final currentState = Theming(0, state);
      realm.write(() {
        realm.add(currentState, update: true);
        realm.refresh();
      });
      return currentState;
    } catch (e) {
      return e.toString();
    }
  }

  clearDB() {
    realm.write(() {
      realm.deleteAll<Theming>();
      realm.refresh();
    });
  }
}
