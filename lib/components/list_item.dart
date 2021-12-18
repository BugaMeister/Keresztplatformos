import 'package:flutter/material.dart';
import 'package:pizza_app/shared/models/meeting.dart';

import 'confirmation-dialog.dart';

class ItemWidget extends StatelessWidget {
  final Meeting meeting;
  late Function loadMeetings;

  ItemWidget({Key? key, required this.meeting, required this.loadMeetings}) : super(key: key);

  openConfirmationDialog(Meeting meeting) {
    // var address = await showDialog<Meeting>(
    //   context: context,
    //   builder: (BuildContext context) => AddressFormDialog(),
    // );
    return ConfirmationDialog(meeting: meeting);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        color: Colors.indigo.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Expanded(
                      child: ConfirmationDialog(meeting: meeting),
                    );
                  }).then((value) => loadMeetings());
            },

            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(meeting.name ?? '',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    Text(meeting.room!.name,
                        style: TextStyle(
                            color: Colors.indigo.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 16))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                ),
                Column(children: <Widget>[
                  Text(
                    "${meeting.time}",
                    style: const TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "${meeting.participants!.displayName}",
                      style: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ])
              ]),
            ),
            //  trailing:
          ),
        ),
      ),
    );
  }
}
