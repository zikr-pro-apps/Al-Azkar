import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:alazkar/src/core/models/zikr.dart';
import 'package:alazkar/src/core/models/zikr_text.dart';
import 'package:alazkar/src/core/models/zikr_title.dart';
import 'package:alazkar/src/core/utils/app_print.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

AzkarDBHelper azkarDBHelper = AzkarDBHelper();

class AzkarDBHelper {
  /* ************* Variables ************* */

  static const String dbName = "Al-Azkar.db";
  static const int dbVersion = 1;

  /* ************* Singleton Constructor ************* */

  static AzkarDBHelper? _instance;
  static Database? _database;

  factory AzkarDBHelper() {
    _instance ??= AzkarDBHelper._createInstance();
    return _instance!;
  }

  AzkarDBHelper._createInstance();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  /* ************* Database Creation ************* */

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    final exist = await databaseExists(path);

    //Check if database is already in that Directory
    if (!exist) {
      // Database isn't exist > Create new Database
      await _copyFromAssets(path: path);
    }

    Database database = await openDatabase(path);

    await database.getVersion().then((currentVersion) async {
      if (currentVersion < dbVersion) {
        appPrint("[DB] New Version Detected");
        database.close();

        //delete the old database so you can copy the new one
        await deleteDatabase(path);

        // Database isn't exist > Create new Database
        await _copyFromAssets(path: path);
      }
    });

    return database = await openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreateDatabase,
      onUpgrade: _onUpgradeDatabase,
      onDowngrade: _onDowngradeDatabase,
    );
  }

  FutureOr<void> _onCreateDatabase(Database db, int version) async {}

  FutureOr<void> _onUpgradeDatabase(
    Database db,
    int oldVersion,
    int newVersion,
  ) {}

  FutureOr<void> _onDowngradeDatabase(
    Database db,
    int oldVersion,
    int newVersion,
  ) {}

  FutureOr<void> _copyFromAssets({required String path}) async {
    try {
      await Directory(dirname(path)).create(recursive: true);

      final ByteData data = await rootBundle.load(join("assets", "db", dbName));
      final List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } catch (e) {
      appPrint(e.toString());
    }
  }

  Future<List<ZikrTitle>> getAllTitles() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('titles');

    return List.generate(maps.length, (i) {
      return ZikrTitle.fromMap(maps[i]);
    });
  }

  Future<List<ZikrTitle>> getTitlesByName(String name) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT * FROM titles WHERE text LIKE ?', ['%$name%']);

    return List.generate(maps.length, (i) {
      return ZikrTitle.fromMap(maps[i]);
    });
  }

  Future<List<Zikr>> getContentByTitleId(int id) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM zikrs WHERE titleId = ?', [id]);
    // TODO: Load sub-zikr item

    final String ids = maps.map((e) => e['id']).toList().join(",");
    final List<Map<String, dynamic>> subZikrMaps =
        await db.rawQuery('SELECT * FROM zikr_texts WHERE zikrId IN ($ids)');

    return List.generate(maps.length, (i) {
      return _parseZikr(maps[i], subZikrMaps);
    });
  }

  Future<Zikr> getContentById(int id) async {
    final Database db = await database;

    final Map<String, dynamic> zikrMap =
        (await db.rawQuery('SELECT * FROM zikrs WHERE id = ?', [id])).first;

    // final String ids = zikrMap.map((e) => e['id']).toList().join(",");
    final List<Map<String, dynamic>> subZikrMaps = await db.rawQuery(
        'SELECT * FROM zikr_texts WHERE zikrId = ?', [zikrMap['id'] as int]);

    return _parseZikr(zikrMap, subZikrMaps);
  }

  /// Close database
  Future close() async {
    final db = await database;
    db.close();
  }

  Zikr _parseZikr(
    Map<String, dynamic> map,
    List<Map<String, dynamic>> subZikrMaps,
  ) {
    final Map<String, dynamic> zikrMap = map;
    final Iterable<Map<String, dynamic>> zikrTextMaps =
        subZikrMaps.where((element) => element['zikrId'] == zikrMap['id']);

    final List<ZikrText> zikrTexts =
        zikrTextMaps.map((ztm) => ZikrText.fromMap(ztm)).toList();
    return Zikr.fromMap(zikrMap, zikrTexts);
  }
}
