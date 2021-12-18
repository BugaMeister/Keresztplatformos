import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

// Adatbázis kapcsolatok kezelése
class Sql {
  Database? _database;

  // Ez a getter létrehozza a kapcsolatot az adatázissal és eltárolja azt
  // későbbi felhasználás céljából.
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDatabase(
      // Az adatbázis fájl alapú. Ennek a fájlnak a helyét állítjuk elő
      join(
        await getDatabasesPath(),
        'pizza_app.db',
      ),
      version: 1,
      // Adatbázis létrehozása. Akkor fog lefutni, amikor az alkalmazásunk először
      // elindul az eszközön. Ha már létezett az alkalmazás, akkor a verziószám
      // növelésével meghívható lesz az onUpdate, ami le tudja kezelni az
      // adatbázis szerkezetének változását.
      onCreate: (db, version) async {
        // Fontos, hogy ha többb táblára van szükség, akkor azokat külön
        // execute hívásban hozzuk létre.
        await db.execute('''
          CREATE TABLE IF NOT EXISTS meetings(
            id INTEGER PRIMARY KEY,
            name TEXT,
            participants text,
            time text,
            roomId integer
          );
        ''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS addresses(
          id INTEGER PRIMARY KEY,
          name TEXT,
          city TEXT,
          street TEXT,
          houseNumber TEXT,
          lat REAL,
          lng REAL
        );
        ''');
        await db.execute('''
        INSERT INTO addresses VALUES 
          (1, 'Mordor', 'Szentes', 'Kossuth utca', '20', 46.39, 20.16),
          (2, 'Megye', 'Szeged', 'Kossuth utca', '20', 46.39, 20.16),
          (3, 'Gondor', 'Budapest', 'Kossuth utca', '20', 46.39, 20.16),
          (4, 'Rohan', 'Szentes', 'Kossuth utca', '20', 46.39, 20.16),
          (5, 'Minathtirith', 'Szentes', 'Kossuth utca', '20', 46.39, 20.16),
          (6, 'Völgyzugoly', 'Szentes', 'Kossuth utca', '20', 46.39, 20.16);
        ''');
        await db.execute('''
        INSERT INTO meetings VALUES 
          (1, 'Gyűrű szövetség', 'Elrond', '2022.01.12 09:00', 6),
          (2, 'Út megbeszélése', 'Gandalf', '2022.01.14 19:00', 2),
          (3, 'Zsizsik úr répái', 'Pippin', '2022.01.16 12:30', 2),
          (4, 'Andúril kovácslása', 'Elrond', '2022.01.15 09:45', 6);
        ''');
      },
    );
    return _database!;
  }
}
