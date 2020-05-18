import 'dart:io';

import 'package:async/async.dart';
import 'package:english_words/english_words.dart' as english_words;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoItem {
  final int id;
  final String content;
  final bool isDone;
  final DateTime createdTime;
  TodoItem({this.id, this.content, this.isDone = false, this.createdTime});

  TodoItem.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        content = map['content'],
        isDone = map['isDone'] == 1,
        createdTime = DateTime.fromMillisecondsSinceEpoch(map['createdAt']);

  Map<String, dynamic> toJosnMap() => {
        'id': id,
        'content': content,
        'isDone': isDone ? 1 : 0,
        'createdTime': createdTime.millisecondsSinceEpoch,
      };
}

class SqliteExample extends StatefulWidget {
  const SqliteExample({Key key}) : super(key: key);

  @override
  _SqliteExampleState createState() => _SqliteExampleState();
}

class _SqliteExampleState extends State<SqliteExample> {
  static const dbFileName = 'sqlLite.db';
  static const dbTableName = 'sql_table_name';
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  Database _db;
  List<TodoItem> _todos = [];

  Future<void> _initDB() async {
    final dbFloder = await getDatabasesPath();
    if (!await Directory(dbFloder).exists()) {
      await Directory(dbFloder).create(recursive: true);
    }
    final dbPath = join(dbFloder, dbFileName);
    this._db = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE $dbTableName(
          id INTEGER PRIMARY KEY, 
          isDone BIT NOT NULL,
          content TEXT,
          createdAt INT)''');
    });
  }

  Future<void> _getTodoItems() async {
    List<Map> jsons = await this._db.rawQuery('SELECT * FROM $dbTableName');
    print('${jsons.length} rows retrieved from db!');
    this._todos = jsons.map((json) {
      return TodoItem.fromJsonMap(json);
    }).toList();
  }

  Future<void> _addTodoItem(TodoItem todo) async {
    await this._db.transaction((Transaction txn) async {
      int id = await txn.rawInsert('''
          INSERT INTO $dbTableName
            (content, isDone, createdAt)
          VALUES
            (
              "${todo.content}",
              ${todo.isDone ? 1 : 0}, 
              ${todo.createdTime.millisecondsSinceEpoch}
            )''');
      print('Inserted todo item with id=$id.');
    });
  }

  Future<void> _toggleTodoItem(TodoItem todo) async {
    int count = await this._db.rawUpdate('''UPDATE $dbTableName
                    SET isDone = ?
                    WHERE id = ?''', [todo.isDone ? 0 : 1, todo.id]);
    print('Updated $count records in db.');
  }

  Future<void> _deleteTodoItem(TodoItem todo) async {
    final count = await this._db.rawDelete('''
        DELETE FROM $dbTableName
        WHERE id = ${todo.id}
      ''');
    print('Updated $count records in db.');
  }

  Future<bool> _asyncInit() async {
    await _asyncMemoizer.runOnce(() async {
      await _initDB();
      await _getTodoItems();
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _asyncInit(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: ListView(
              children: this._todos.map(_itemToListTile).toList(),
            ),
            floatingActionButton: _buildFloatingActionButton(),
          );
        });
  }

  Future<void> _updateUI() async {
    await _getTodoItems();
    setState(() {});
  }

  ListTile _itemToListTile(TodoItem todo) => ListTile(
        title: Text(
          todo.content,
          style: TextStyle(
              fontStyle: todo.isDone ? FontStyle.italic : null,
              color: todo.isDone ? Colors.grey : null,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        subtitle: Text('id=${todo.id}\ncreated at ${todo.createdTime}'),
        isThreeLine: true,
        leading: IconButton(
          icon: Icon(
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank),
          onPressed: () async {
            await _toggleTodoItem(todo);
            _updateUI();
          },
        ),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await _deleteTodoItem(todo);
              _updateUI();
            }),
      );

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        await _addTodoItem(
          TodoItem(
            content: english_words.generateWordPairs().first.asPascalCase,
            createdTime: DateTime.now(),
          ),
        );
        _updateUI();
      },
    );
  }
}
