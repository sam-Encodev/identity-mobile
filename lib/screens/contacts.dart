import 'package:realm/realm.dart';
import 'package:flutter/material.dart';
import 'package:identity/model/user.dart';
import 'package:identity/schema/user.dart';
import 'package:identity/components/empty_screen.dart';
import 'package:identity/components/contacts/list.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    RealmResults<User> users = UserModel().getUsers();

    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        actions: [
          SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return IconButton(
                onPressed: controller.openView,
                icon: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (
              BuildContext context,
              SearchController controller,
            ) {
              return users
                  .where((User user) {
                    final String name = user.name.toLowerCase();
                    final String mobile = user.mobile.toLowerCase();
                    final String input = controller.text.toLowerCase();

                    return name.contains(input) || mobile.contains(input);
                  })
                  .map((User user) {
                    return ListTile(
                      title: Text(user.name),
                      onTap: () => controller.closeView(user.name),
                    );
                  });
            },
          ),
        ],
      ),
      body: StreamBuilder<Object>(
        stream: users.changes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final users = (snapshot.data as RealmResultsChanges<User>?)?.results;
          return users!.isEmpty
              ? Center(child: EmptyScreen())
              : Padding(
                padding: const EdgeInsets.all(12.0),
                child: ContactList(users: users.toList()),
              );
        },
      ),
    );
  }
}
