import 'package:flutter/material.dart';
import 'package:pizza_app/shared/l10n/meetings_app_localizations.dart';
import 'package:pizza_app/shared/models/address.dart';
import 'package:pizza_app/components/address_map.dart';

class AddressCard extends StatelessWidget {
  final Address address;

  AddressCard({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => (print("id: "+this.address.id.toString())),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('${MeetingsAppLocalizations.of(context)!.name}: '),
                  Text(address.name),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('${MeetingsAppLocalizations.of(context)!.city}: '),
                  Text(address.city),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('${MeetingsAppLocalizations.of(context)!.street}: '),
                  Text(address.street),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('${MeetingsAppLocalizations.of(context)!.houseNumber}: '),
                  Text(address.houseNumber),
                ],
              ),
              AddressMap(address: address),
            ],
          ),
        ),
      ),
    );
  }
}
