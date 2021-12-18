import 'package:flutter/material.dart';
import 'package:pizza_app/shared/l10n/meetings_app_localizations.dart';
import 'package:pizza_app/shared/models/meeting.dart';
import 'package:pizza_app/shared/db/meetings_repository.dart';
import 'package:provider/src/provider.dart';

class ConfirmationDialog extends StatelessWidget {
  final Meeting meeting;

  ConfirmationDialog({Key? key, required this.meeting}) : super(key: key);

  deleteMeeting(BuildContext context) {
    MeetingsRepository _meetingsRepository = context.read<MeetingsRepository>();
    _meetingsRepository.removeMeeting(meeting);
    Navigator.of(context).pop();
  }

  cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: Text(MeetingsAppLocalizations.of(context)!.sureToDelete),
        children: <Widget>[
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () => deleteMeeting(context),
                    backgroundColor: Colors.red,
                    child: Text(MeetingsAppLocalizations.of(context)!.yes),
                  ),
                  FloatingActionButton(
                    onPressed: () => cancel(context),
                    backgroundColor: Colors.red,
                    child: Text(MeetingsAppLocalizations.of(context)!.no),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
