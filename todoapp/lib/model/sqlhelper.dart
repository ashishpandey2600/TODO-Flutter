import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
check BOOLEAN NOT NULL CHECK (mycolumn IN (0, 1)),
description TEXT,
createdAT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('dbtech.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(check, String? description) async {
    final db = await SQLHelper.db();
    final data = {'check': check, 'description': description};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = >", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, check, String? description) async {
    final db = await SQLHelper.db();
    final data = {
      'check': check,
      'description': description,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('items', data, where: "if = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went wrong when deleting an item: $e");
    }
  }
}
