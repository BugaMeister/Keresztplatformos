import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:pizza_app/shared/l10n/meetings_app_localizations.dart';
import 'package:pizza_app/shared/models/address.dart';
import 'package:pizza_app/shared/models/meeting.dart';
import 'package:pizza_app/components/contact_chooser.dart';
import 'package:pizza_app/shared/db/meetings_repository.dart';
import 'package:provider/src/provider.dart';
import 'package:select_form_field/select_form_field.dart';

class MeetingForm extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Meeting? meeting;

  MeetingForm({
    Key? key
  }) : super(key: key);

  @override
  _MeetingFormState createState() => _MeetingFormState();
}

class _MeetingFormState extends State<MeetingForm> {
  final _formKey = GlobalKey<FormState>();
  late MeetingsRepository _meetingsRepository;
  List<Map<String, dynamic>>? _addresses;
  List<Address>? _addressesList;

  late Meeting meeting;

  // These controllers can be used to get the value entered into the input field
  late TextEditingController _nameController;
  late TextEditingController _roomController;
  late Contact? _participantsController;
  late TextEditingController _timeController;

  void chooseAContact(BuildContext context) async {
    var meeting = context.read<Meeting>();
    if (await Permission.contacts
        .request()
        .isGranted) {
      Contact contact = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ContactChooser()),
      );
      meeting.setParticipants(contact);
      _participantsController = contact;
    } else if (await Permission.contacts.isPermanentlyDenied) {
      openAppSettings();
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Permission denied"),
          ),
        );
    }
  }

  void removeSelectedContact(BuildContext context) {
    //context.read<Cart>().setEater(item, null);
  }

  @override
  void initState() {
    super.initState();
    _meetingsRepository = context.read<MeetingsRepository>();
    _loadProfile();
    meeting = new Meeting();
    //meeting.participants = null;

    _nameController =
        TextEditingController.fromValue(TextEditingValue(text: ''));
    _timeController =
        TextEditingController.fromValue(TextEditingValue(text: ''));
    _roomController =
        TextEditingController.fromValue(TextEditingValue(text: ''));
    _participantsController = new Contact();
  }

  Future<void> _loadProfile() async {
    _addressesList = await _meetingsRepository.loadAddresses();
    setState(() {
      _addresses = <Map<String, dynamic>>[];
      for (Address a in _addressesList!) {
        _addresses!.add(a.toSelectMap());
      }
    });
  }

  void saveMeeting(BuildContext context) async {
    var repository = context.read<MeetingsRepository>();
    //widget.meeting!.name = this._nameController.text.toString();
    Meeting savedMeeting = new Meeting();
    for (Address a in _addressesList!) {
      if (a.id == int.parse(_roomController.text)) {
        savedMeeting.roomId = int.parse(_roomController.text);
        savedMeeting.room = a;
      }
    }
    savedMeeting.name = _nameController.text;
    savedMeeting.time = _timeController.text;
    savedMeeting.participants = _participantsController;
    await repository.save(savedMeeting);
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
              "Mentés sikeres"), //MeetingsAppLocalizations.of(context)!.profileSaved),
        ),
      );
    // await loadMeetings();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (_addresses != null)
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: SelectFormField(
                  key: Key('value'),
                  type: SelectFormFieldType.dialog,
                  // or can be dialog
                  initialValue: 'circle',
                  labelText: 'Select a room',
                  items: _addresses,
                  onChanged: (val) => {_roomController.text = val}),
            ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: DateTimePicker(
                controller: _timeController,
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'yyyy.MM.dd',
                errorInvalidText: "Please enter a valid time",
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                icon: Icon(Icons.event),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (DateTime.parse(value).isBefore(DateTime.now())) {
                    return 'Time is already passed';
                  }
                  return null;
                },
                lastDate: DateTime(2100),
                firstDate: DateTime(DateTime
                    .now()
                    .year, DateTime
                    .now()
                    .month,
                    DateTime
                        .now()
                        .day),
              )),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Row(
              children: <Widget>[
                RaisedButton.icon(
                  onPressed: () {
                    chooseAContact(context);
                  },
                  icon: const Icon(Icons.contacts),
                  label: Text(Provider
                      .of<Meeting>(context)
                      .participants
                      ?.displayName ??
                      MeetingsAppLocalizations.of(context)!.whoWillEat),
                ),
                if (Provider
                    .of<Meeting>(context)
                    .participants
                    ?.displayName != null)
                  IconButton(
                    onPressed: () {
                      removeSelectedContact(context);
                    },
                    icon: const Icon(Icons.remove_circle),
                  ),
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate() && this._participantsController!.displayName!.isNotEmpty && this._roomController.text.isNotEmpty) {
                  // widget.meeting.name = _nameController.value.text;
                  // widget.meeting.time = _timeController.value.text;
                  saveMeeting(context);
                  Navigator.of(context).pop();
                  // Process data.
                }
              },
              child: Text(MeetingsAppLocalizations.of(context)!.addMeeting),
            ),
          ),
        ],
      ),
    );
  }

}
