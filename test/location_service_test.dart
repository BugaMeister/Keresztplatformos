import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:pizza_app/location_service.dart';
import 'package:pizza_app/shared/models/address.dart';

// Definiálunk egy ál HTTP klienst a mockito csomag segítségével.
class MockClient extends Mock implements http.Client {}

void main() {
  group('LocationService', () {
    test('looks up the address', () async {
      // Létrehozunk egy ál HTTP klienst. Ez nem fog HTTP kéréseket küldeni,
      // így a tesztjeinkkel nem terheljük a távoli szervert.
      final client = MockClient();

      var address =
          Address(name: 'Bugya Tér', city: 'Budapest', street: 'Váci út', houseNumber: '12');

      // Megmondjuk, hogy amikor az ál HTTP klienst ezekkel a paraméterekkel
      // hívjuk meg, akkor mi legyen a visszatérési érték.
      when(() => client.get(Uri.parse(
              'https://nominatim.openstreetmap.org/search?format=json&counrty=Hungary&city=Budapest&street=12 Váci út')))
          .thenAnswer(
        (_) => Future.value(
          http.Response(
              '[{"place_id":15976088,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"node","osm_id":1468818748,"boundingbox":["47.5128019","47.5129019","19.057147","19.057247"],"lat":"47.5128519","lon":"19.057197","display_name":"12, Váci út, Újlipótváros, VI. kerület, Budapest, Közép-Magyarország, 1132, Magyarország","class":"place","type":"house","importance":0.42099999999999993}]',
              200),
        ),
      );

      // Használjuk a saját kódunkat, ahogy eddig is. Paraméterben átadjuk az
      // ál HTTP kliensünket.
      var result = await LocationService.find(address, httpClient: client);

      // Ellenőrizzük a végeredményt.
      expect(result.latitude.toDouble(), closeTo(47.5128519, 0.000000001));
      expect(result.longitude.toDouble(), closeTo(19.057197, 0.000000001));
    });
  });
}
