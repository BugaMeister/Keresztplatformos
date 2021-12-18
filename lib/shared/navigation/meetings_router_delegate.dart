import 'package:flutter/material.dart';
import 'package:pizza_app/screens/home_page.dart';
import 'package:pizza_app/screens/rooms_page.dart';
import 'package:pizza_app/screens/unknown.dart';

import 'meetings_route_path.dart';

class MeetingsRouterDelegate extends RouterDelegate<MeetingsRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MeetingsRoutePath> {
  final GlobalKey<NavigatorState> _navigatorKey;

  bool show404 = false;
  bool showRooms = false;

  MeetingsRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  MeetingsRoutePath get currentConfiguration {
    if (show404) {
      return MeetingsRoutePath.unknown();
    }
    if (showRooms) {
      return MeetingsRoutePath.rooms();
    }
    return MeetingsRoutePath.home();
  }

  // Ebben a metódusban rakjuk össze, hogyan épül fel a stack.
  // A pages tömb írja le, hogy mi szerepel a history-ban. Ha a tartalma
  // változik, akkor a rendszer összehasonlítja az előző állapottal és képernyőt
  // vált a megfelelő animáció kíséretében
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        // A HomePage mindig szereplni fog az oldalak között.
        MaterialPage(
          key: ValueKey('HomePage'),
          child: HPage(),
        ),
        // Ha ismeretlen oldalra tévedtünk, akkor az Unknown widget
        // fog megjelenni
        if (show404)
          MaterialPage(
            key: ValueKey('UnknownPage'),
            child: Unknown(),
          )
        else if (showRooms)
          MaterialPage(
            key: ValueKey('RoomsPage'),
            child: RoomListPage(),
          )
        // else if (showCart)
        //   MaterialPage(
        //     key: ValueKey('CartPage'),
        //     child: CartPage(
        //       onShowRooms: _handleshowRooms,
        //     ),
        //   )
        // else if (_selectedPizza != null)
        //   // Egyébként a rendelési oldalon vagyunk, és az URL alapján a rendszer
        //   // beazonosította, hogy melyik pizzát kell megjeleníteni.
        //   MaterialPage(
        //     key: ObjectKey(_selectedPizza),
        //     child: PizzaDetails(
        //       pizza: _selectedPizza!,
        //       onShowRooms: _handleshowRooms,
        //       onShowCart: _handleShowCart,
        //     ),
        //   ),
      ],
      // Akkor fut le, amikor kikerül egy elem a stack-ből.
      // Jelen esetben ez azt jelenti, hogy elhagytuk a PizzaDetails widget-et,
      // így nincs kiválasztott pizzánk
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        show404 = false;
        showRooms = false;
        // A notifyListener meghívásával jelezhetjük a Router felé,
        // hogy változott a navigációs állapot és frissítenie kell
        // a megjelenítést
        notifyListeners();

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // Akkor fut le ha a rendszer szól az alkalmazásunknak, hogy egy új
  // útvonalat kell megjeleníteni, például, ha kézzel beírok egy URL-t a
  // böngészőbe.
  @override
  Future<void> setNewRoutePath(MeetingsRoutePath path) async {}

  void _handleshowRooms() {
    showRooms = true;
    notifyListeners();
  }
}
