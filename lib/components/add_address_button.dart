import 'package:flutter/material.dart';
import 'package:pizza_app/shared/l10n/meetings_app_localizations.dart';
import 'package:pizza_app/location_service.dart';
import 'package:pizza_app/shared/models/address.dart';
import 'package:pizza_app/components/address_form_dialog.dart';
import 'package:pizza_app/shared/db/meetings_repository.dart';
import 'package:provider/provider.dart';

// Manages the address creation
class AddAddressButton extends StatelessWidget {
  final Function onAddressSaved;

  AddAddressButton({
    Key? key,
    required this.onAddressSaved,
  }) : super(key: key);

  Future<void> _addAddress(BuildContext context) async {
    var address = await showDialog<Address>(
      context: context,
      builder: (BuildContext context) => AddressFormDialog(),
    );
    if (address != null) {
      // Get the repository through Provider
      var repository = context.read<MeetingsRepository>();
      // Get the latitude and longitude values for that address
      address.latLng = await LocationService.find(address);
      // Save the address into the DB
      await repository.addAddress(address);

      // Call the callback
      await onAddressSaved();
      // Show info to the user
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(MeetingsAppLocalizations.of(context)!.addressSaved),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _addAddress(context);
      },
      backgroundColor: Colors.red,
      child: Icon(Icons.add),
    );
  }
}
