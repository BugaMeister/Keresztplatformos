import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pizza_app/shared/l10n/meetings_app_localizations.dart';
import 'package:pizza_app/shared/navigation/meetings_route_information_parser.dart';
import 'package:pizza_app/shared/db/meetings_repository.dart';
import 'package:pizza_app/shared/db/sql.dart';
import 'package:pizza_app/shared/navigation/meetings_router_delegate.dart';
import 'package:provider/provider.dart';

import 'shared/models/meeting.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Elérhető kamerák listája
  final cameras = await availableCameras();

  // Kivesszük a legelső kamerát a listából
  final camera = cameras.length > 0 ? cameras.first : null;

  final sql = Sql();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Meeting(),
        ),
        Provider(
          create: (_) => MeetingsRepository(sql: sql),
        ),
        // A kamera a Provider-en keresztül lesz elérhető.
        Provider.value(value: camera),
      ],
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late MeetingsRouterDelegate _routerDelegate;
  late MeetingsRouteInformationParser _routeInformationParser;

  @override
  void initState() {
    super.initState();
    _routeInformationParser = MeetingsRouteInformationParser();
    _routerDelegate = MeetingsRouterDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
      // A nyelvi osztályokat regisztráló delegate objektumok listája
      // Ezeken keresztül tölti be a rendszer szükség esetén az éppen aktuális
      // nyelv alapján a megfelelő localization osztályokat, amiken keresztül
      // elérhetjük a lefordított szövegeket.
      localizationsDelegates: [
        MeetingsAppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // Az alkalmazásunk által támogatott nyelvek listája
      supportedLocales: [
        const Locale('en', ''),
        const Locale('hu', ''),
      ],
    );
  }
}
