import 'package:flutter/material.dart';
import 'package:pizza_app/shared/l10n/meetings_app_localizations.dart';

class Unknown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(MeetingsAppLocalizations.of(context)!.unknown),
          ],
        ),
      ),
    );
  }
}
