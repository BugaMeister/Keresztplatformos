import 'package:flutter/material.dart';
import 'package:pizza_app/shared/l10n/meetings_app_localizations.dart';
import 'package:pizza_app/shared/models/address.dart';
import 'package:pizza_app/components/add_address_button.dart';
import 'package:pizza_app/components/address_card.dart';
import 'package:pizza_app/shared/db/meetings_repository.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({
    Key? key,
  }) : super(key: key);

  @override
  _RoomListPageState createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  late MeetingsRepository _meetingsRepository;
  List<Address> addresses = [];

  @override
  void initState() {
    super.initState();
    _meetingsRepository = context.read<MeetingsRepository>();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    var loadedAddresses = await _meetingsRepository.loadAddresses();
    setState(() {
      addresses = loadedAddresses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            MeetingsAppLocalizations.of(context)!.rooms,
            style: TextStyle(color: Colors.grey[900]),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Column(
            children: <Widget>[
              Expanded(
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
              ),
            ],
          ),
        ),
        floatingActionButton: AddAddressButton(onAddressSaved: _loadAddresses,),

      ),
    );
  }
}
