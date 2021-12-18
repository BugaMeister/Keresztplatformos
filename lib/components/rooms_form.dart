import 'package:flutter/material.dart';
import 'package:pizza_app/shared/l10n/meetings_app_localizations.dart';
import 'package:pizza_app/shared/models/address.dart';
import 'package:pizza_app/components/address_card.dart';
import 'package:pizza_app/shared/db/meetings_repository.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {
  ProfileForm({Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late MeetingsRepository _meetingsRepository;
  late List<Address> addresses;

  @override
  void initState() {
    super.initState();
    _meetingsRepository = context.read<MeetingsRepository>();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    addresses = await _meetingsRepository.loadAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                MeetingsAppLocalizations.of(context)!.addresses,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (addresses.length > 0)
              ...addresses
                  .map((address) => AddressCard(address: address))
                  .toList()
          ],
        ),
      ),
    );
  }
}
