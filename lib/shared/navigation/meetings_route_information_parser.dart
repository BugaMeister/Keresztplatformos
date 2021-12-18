import 'package:flutter/material.dart';

import 'meetings_route_path.dart';

class MeetingsRouteInformationParser
    extends RouteInformationParser<MeetingsRoutePath> {
  @override
  Future<MeetingsRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    // Kezdő oldal
    if (uri.pathSegments.length == 0) {
      return MeetingsRoutePath.home();
    }

    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'rooms') {
      return MeetingsRoutePath.rooms();
    }

    // Ismeretlen útvonal
    return MeetingsRoutePath.unknown();
  }

  // Saját belső útvonal reprezentációnk alapján állítja elő az
  // útvonal információkat. Web-es platform esetén használatos.
  @override
  RouteInformation? restoreRouteInformation(MeetingsRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }

    if (path.isProfile) {
      return RouteInformation(location: '/rooms');
    }

    return null;
  }
}
