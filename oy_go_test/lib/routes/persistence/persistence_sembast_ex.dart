/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/4
 */
import 'package:english_words/english_words.dart' as english_words;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TodoItem {
  final int id;
  final String content;
  bool isDone;
  final DateTime createdAt;

  TodoItem({this.id, this.content, this.isDone = false, this.createdAt});

  TodoItem.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        content = map['content'],
        isDone = map['isDone'],
        createdAt = DateTime.fromMillisecondsSinceEpoch(map['createdAt']);

  Map<String, dynamic> toJsonMap() => {
        'id': id,
        'content': content,
        'isDone': isDone,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };
}

class SembastExample extends StatefulWidget {
  const SembastExample({Key key}) : super(key: key);

  @override
  _SembastExampleState createState() => _SembastExampleState();
}

class _SembastExampleState extends State<SembastExample> {
  static const dbFileName = 'sembast.db';
  static const dbStoreName = 'example_store';
  Future<bool> _initDBFuture;
  Database _db;
  StoreRef<int, Map<String, dynamic>> _store;
  List<TodoItem> _todos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._initDBFuture = _initDB();
  }

  Future<bool> _initDB() async {
    final dbFolder = await path_provider.getApplicationDocumentsDirectory();
    final dbPath = join(dbFolder.path, dbFileName);
    this._db = await databaseFactoryIo.openDatabase(dbPath);
    print('Db created at $dbPath');
    this._store = intMapStoreFactory.store(dbStoreName);
    _getTodoItems();
    return true;
  }

  Future<void> _getTodoItems() async {
    final finder = Finder();
    final recordSnapshot = await this._store.find(this._db, finder: finder);
    this._todos = recordSnapshot.map((snapshot) {
      return TodoItem.fromJsonMap({
        ...snapshot.value,
        "id": snapshot.key,
      });
    }).toList();
  }

  Future<void> _addTodoItem(TodoItem todo) async {
    int id = await this._store.add(this._db, todo.toJsonMap());
    print('Inserted todo item with id=$id.');
  }

  Future<void> _toggleTodoItem(TodoItem todo) async {
    todo.isDone = !todo.isDone;
    int count = await this._store.update(this._db, todo.toJsonMap(),
        finder: Finder(filter: Filter.byKey(todo.id)));
    print('Updated $count records in db.');
  }

  Future<void> _deleteTodoItem(TodoItem todo) async {
    int count = await this._store.delete(
          this._db,
          finder: Finder(filter: Filter.byKey(todo.id)),
        );
    print('Updated $count records in db.');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: this._initDBFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Scaffold(
          body: ListView(
            children: this._todos.map(_itemToListTile).toList(),
          ),
          floatingActionButton: _buildFloatingActionButton(),
        );
      },
    );
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
        subtitle: Text('id=${todo.id}\ncreated at ${todo.createdAt}'),
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
            createdAt: DateTime.now(),
          ),
        );
        _updateUI();
      },
    );
  }
}
