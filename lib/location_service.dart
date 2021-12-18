import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pizza_app/shared/models/address.dart';

const SZEGED_LATLNG = LatLng(46.2587, 20.14222);

class LocationService {
  static Future<LatLng> find(Address address, {http.Client? httpClient}) async {
    var client = httpClient ?? http.Client();
    var result = SZEGED_LATLNG;
    try {
      var response = await client.get(_buildUrl(address));
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.body);
        if (data.length > 0) {
          result = LatLng(
              double.parse(data[0]['lat']), double.parse(data[0]['lon']));
        }
      }
    } finally {
      if (httpClient == null) {
        client.close();
      }
    }
    return result;
  }

  static Uri _buildUrl(Address address) {
    return Uri.parse(
        'https://nominatim.openstreetmap.org/search?format=json&counrty=Hungary&city=${address.city}&street=${address.houseNumber} ${address.street}');
  }
}
