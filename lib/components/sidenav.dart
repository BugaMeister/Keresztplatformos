import 'package:flutter/material.dart';
import 'package:pizza_app/shared/l10n/meetings_app_localizations.dart';
import 'package:pizza_app/screens/easter_egg.dart';
import 'package:pizza_app/components/add_address_button.dart';
import 'package:pizza_app/components/address_form_dialog.dart';
import 'package:pizza_app/screens/rooms_page.dart';

import '../main.dart';

class SideNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: Text(MeetingsAppLocalizations.of(context)!.rooms),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RoomListPage()),
              );
            },
          ),
          ListTile(
            title: Text("Easter Egg"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EasterEgg()),
              );
            },
          ),
          // ListTile(
          //   title: const Text('Rooms'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const RoomList()),
          //     );
          //   },
          // ),
          // ListTile(
          //   title: const Text('Easter Egg'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const EasterEgg()),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
