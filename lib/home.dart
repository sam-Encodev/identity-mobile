import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
import 'package:identity/constants/text.dart';
import 'package:identity/screens/search.dart';
import 'package:identity/screens/contacts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentPageIndex = 0;
  final List<Widget> _screens = [Search(), Contacts()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.inversePrimary,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: FIcon(
              FAssets.icons.search,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            icon: FIcon(
              FAssets.icons.search,
              color: Theme.of(context).colorScheme.outline,
            ),
            label: search,
          ),
          NavigationDestination(
            selectedIcon: FIcon(
              FAssets.icons.personStanding,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            icon: FIcon(
              FAssets.icons.personStanding,
              color: Theme.of(context).colorScheme.outline,
            ),
            label: contacts,
          ),
        ],
      ),
    );
  }
}
