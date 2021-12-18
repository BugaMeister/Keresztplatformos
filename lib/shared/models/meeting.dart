import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'address.dart';

class Meeting with ChangeNotifier{
  late int? id;
  late String? name;
  Contact? participants;
  late String? time;
  late int? roomId;
  late Address? room;

  Meeting({this.id, this.name, this.participants, this.time, this.roomId, this.room});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'name': name,
      'participants': participants!.displayName,
      'time': time,
      'roomId': roomId,
      'room': room!.name
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  void setParticipants(Contact contact){
    this.participants = contact;
    notifyListeners();
  }
}
