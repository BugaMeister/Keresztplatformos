import 'package:flutter/material.dart';

import 'meeting_form.dart';

class AddMeetingDialog extends StatefulWidget {
  const AddMeetingDialog({Key? key}) : super(key: key);

  @override
  _AddMeetingDialogState createState() => _AddMeetingDialogState();
}

class _AddMeetingDialogState extends State<AddMeetingDialog> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: const Text('New meeting'),
        children: <Widget>[MeetingForm()],
      ),
    );
  }
}
