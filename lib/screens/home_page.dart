import 'package:flutter/material.dart';
import 'package:pizza_app/components/add-meeting-dialog.dart';
import 'package:pizza_app/components/list_item.dart';
import 'package:pizza_app/components/sidenav.dart';
import 'package:pizza_app/shared/models/meeting.dart';
import 'package:pizza_app/shared/db/meetings_repository.dart';
import 'package:provider/src/provider.dart';

class HPage extends StatefulWidget {
  const HPage({Key? key}) : super(key: key);

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<HPage> {
  late MeetingsRepository _meetingsRepository;
  List<Meeting> meetings = [];

  @override
  void initState() {
    super.initState();
    _meetingsRepository = context.read<MeetingsRepository>();
    _loadMeetings();
  }

  Future<void> _loadMeetings() async {
    var loadedMeetings = await _meetingsRepository.loadMeetings();
    setState(() {
      meetings = loadedMeetings;
    });
  }

  // Future<dynamic> _addMeeting(dynamic context, func) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Expanded(
  //         child: AddMeetingDialog(loadMeetings: func),
  //       );
  //     },
  //   );
  // }

  meetingList() {
    return meetings.length > 0
        ? ListView.builder(
            itemCount: meetings.length,
            itemBuilder: (context, index) {
              return ItemWidget(
                meeting: meetings[index],
                loadMeetings: _loadMeetings,
              );
            })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar:
              AppBar(backgroundColor: Colors.blue, title: Text('Meetings App')),
          // A Container egy általános tároló elem, amivel könnyen lehet méretezni,
          // színezni a tartalmát
          body: Container(
            // A megjelenését a BoxDecoration írja le, amiben azt tudjuk megmondani,
            // hogyan rajzolja ki a Container dobozát
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: meetingList(),
            // ListView.builder(
            //     itemCount: meetings.length,
            //     itemBuilder: (context, index) {
            //       return ItemWidget(meeting: meetings[index], loadMeetings: _loadMeetings,);
            //     }),
            // A Column egy elrendezéshez használható widget. Az elemei egymás alá
            // kerülnek
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Expanded(
                          child: AddMeetingDialog(),
                        );
                      },
                    ).then((value) => _loadMeetings());
                  },
                  child: const Icon(Icons.more_time),
                ),
              ],
            ),
          ),
          drawer: SideNav()),
    );
  }
}
