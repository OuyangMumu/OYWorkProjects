import 'package:english_words/english_words.dart' as english_words;
/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/5
 */

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oy_go_test/routes/data/todo_item.dart'
    show TodoItem, TodoItemAdapter;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveExample extends StatefulWidget {
  const HiveExample({Key key}) : super(key: key);

  @override
  _HiveExampleState createState() => _HiveExampleState();
}

class _HiveExampleState extends State<HiveExample> {
  static const hiveFolderName = 'hive';
  static const hiveBoxName = 'hiveBox';
  Future<bool> _initDbFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._initDbFuture = _initDB();
  }

  Future<bool> _initDB() async {
    final dir = await path_provider.getApplicationDocumentsDirectory();
    final hiveFolder = join(dir.path, hiveFolderName);
    Hive.init(hiveFolder);
    try {
      Hive.registerAdapter(TodoItemAdapter());
    } on HiveError catch (e) {
      print(e);
    }
    await Hive.openBox<TodoItem>(hiveBoxName);
    final List<TodoItem> todos = _getTodoItems();
    print('Hive initialization done, todo items in the db are:');
    todos.forEach(print);
    return true;
  }

  @override
  void dispose() {
    Hive.box(hiveBoxName).compact();
    Hive.close();

    super.dispose();
  }

  List<TodoItem> _getTodoItems() {
    final box = Hive.box<TodoItem>(hiveBoxName);
    return box.values.toList();
  }

  Future<void> _addTodoItem(TodoItem todo) async {
    final box = Hive.box<TodoItem>(hiveBoxName);
    int key = await box.add(todo);
    todo.id = key;
    await todo.save();
    print('Inserted: key=$key, value=$todo');
  }

  Future<void> _toggleTodoItem(TodoItem todo) async {
    todo.isDone = !todo.isDone;
    todo.save();
    print('Updated: key=${todo.id}, value=$todo');
  }

  Future<void> _deleteTodoItem(TodoItem todo) async {
    await todo.delete();
    print('Delted: key=${todo.id}, value=$todo');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this._initDbFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: ValueListenableBuilder(
              valueListenable: Hive.box<TodoItem>(hiveBoxName).listenable(),
              builder: (context, box, _) => ListView(
                children: <Widget>[
                  for (TodoItem item in box.values) _itemToListTile(item)
                ],
              ),
            ),
            floatingActionButton: _buildFloatingActionButton(),
          );
        });
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
          onPressed: () => _toggleTodoItem(todo),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _deleteTodoItem(todo),
        ),
      );

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        await _addTodoItem(
          TodoItem(
            content: english_words.generateWordPairs().first.asPascalCase,
          ),
        );
      },
    );
  }
}
