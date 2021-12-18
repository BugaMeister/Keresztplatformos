import 'package:contacts_service/contacts_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizza_app/location_service.dart';
import 'package:pizza_app/shared/models/address.dart';
import 'package:pizza_app/shared/models/meeting.dart';
import 'package:pizza_app/shared/db/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class MeetingsRepository {
  final Sql sql;

  MeetingsRepository({required this.sql});

  Future<List<Meeting>> loadMeetings() async {
    final Database database = await sql.database;
    final List<Map<String, dynamic>> result = await database.rawQuery(
      'select *, meetings.name as meetingName, addresses.name as addressName from meetings left join addresses on meetings.roomId = addresses.id order by meetings.id DESC',
    );
    var addresses = loadAddresses();
    // Átalakítjuk az adatot Address objektumokká
    return List.generate(result.length, (i) {
      return Meeting(
          id: result[i]['id'],
          name: result[i]['meetingName'],
          participants: new Contact(displayName: result[i]['participants']),
          time: result[i]['time'],
          roomId: result[i]['roomId'],
          room: new Address(name: result[i]['addressName'], city: result[i]['city'], street: result[i]['street'], houseNumber: result[i]['houseNumber'])

      );
    });
  }

  removeMeeting(Meeting meeting) async {
    final Database database = await sql.database;
    database.delete(
      'meetings',
      where: 'id = ?',
      whereArgs: [meeting.id],
    );
  }

  Future<List<Address>> loadAddresses() async {
    final Database database = await sql.database;
    final List<Map<String, dynamic>> result = await database.query(
      'addresses',
      orderBy: 'id DESC',
    );

    // Átalakítjuk az adatot Address objektumokká
    return List.generate(result.length, (i) {
      return Address(
          id: result[i]['id'],
          name: result[i]['name'],
          city: result[i]['city'],
          street: result[i]['street'],
          houseNumber: result[i]['houseNumber'],
          latLng: LatLng(result[i]['lat'] ?? SZEGED_LATLNG.latitude,
              result[i]['lng'] ?? SZEGED_LATLNG.longitude));
    });
  }

  Future<List<Address>> loadAllAddresses(Sql sql) async {
    final Database database = await sql.database;
    // Az összes cím betöltése az adresses táblából
    final List<Map<String, dynamic>> result = await database.query(
      'addresses',
      orderBy: 'id DESC',
    );

    // Átalakítjuk az adatot Address objektumokká
    return List.generate(result.length, (i) {
      return Address(
          id: result[i]['id'],
          name: result[i]['name'],
          city: result[i]['city'],
          street: result[i]['street'],
          houseNumber: result[i]['houseNumber'],
          latLng: LatLng(result[i]['lat'] ?? SZEGED_LATLNG.latitude,
              result[i]['lng'] ?? SZEGED_LATLNG.longitude));
    });
  }

  Future<void> save(Meeting? meeting) async {
    if (meeting != null) {
      final Database database = await sql.database;
      // Profil mentése az adazbázisba. Ha már létezett, akkor felülírjuk
      var m = meeting.toMap();
      m.remove("room");
      meeting.id = await database.insert('meetings', m,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    // removeAllAddresses();
    // profile.addresses.forEach((address) {
    //   addAddress(address);
    // });
  }

  Future<void> addAddress(Address address) async {
    final Database database = await sql.database;
    address.id = await database.insert(
      'addresses',
      address.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeAllAddresses() async {
    final Database database = await sql.database;
    database.delete('addresses');
  }

  Future<void> removeAddress(Address address) async {
    final Database database = await sql.database;
    database.delete(
      'addresses',
      where: 'id = ?',
      whereArgs: [address.id],
    );
  }
}
