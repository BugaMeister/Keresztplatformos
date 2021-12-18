import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiver/core.dart';

class Address {
  int? id;
  String name;
  String city;
  String street;
  String houseNumber;
  LatLng? latLng;

  Address({
    this.id,
    required this.name,
    required this.city,
    required this.street,
    required this.houseNumber,
    this.latLng,
  });

  @override
  bool operator ==(Object value) =>
      value is Address &&
      value.name == name &&
      value.city == city &&
      value.street == street &&
      value.houseNumber == houseNumber;

  @override
  int get hashCode => hash4(name, city, street, houseNumber);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'name': name,
      'city': city,
      'street': street,
      'houseNumber': houseNumber,
    };
    if (id != null) {
      map['id'] = id!;
    }
    if (latLng != null) {
      map['lat'] = latLng!.latitude;
      map['lng'] = latLng!.longitude;
    }
    return map;
  }

  Map<String, dynamic> toSelectMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'label': name,
      'value': id,
    };
    return map;
  }
}
