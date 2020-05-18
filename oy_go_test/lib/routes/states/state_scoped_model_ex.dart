import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopedModelExample extends StatelessWidget {
  const ScopedModelExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: MyDemoApp(),
    );
  }
}

class MyDemoApp extends StatelessWidget {
  const MyDemoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Text("ScopedModel allows efficient sharing/updating of app's state from "
          "children widgets down the widgets tree.\n\n"
          "In this example, the app's root widget is a ScopedModel, "
          "so it's state is shared to the two 'CounterAndButtons' children"
          " widgets below. \n\n"
          "Clicking on child widget's button would update the MyStateModel "
          "of root widget.\n"),
      // ###2. Put the ScopedModel at the root of the widget tree, so that all
      // children widget can access the state.
      ScopedModel(
        model: _MyState(),
        child: _AppRootWidget(),
      ),
    ]);
  }
}

class _AppRootWidget extends StatelessWidget {
  const _AppRootWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<_MyState>(builder: (context, child, model) {
      return Card(
        elevation: 4.0,
        child: Column(children: [
          Text('(root widget)'),
          Text(
            '${model.counterValue}',
            style: Theme.of(context).textTheme.display1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _CounterAndButton(),
              _CounterAndButton(),
            ],
          ),
        ]),
      );
    });
  }
}

class _CounterAndButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<_MyState>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        return Card(
          margin: EdgeInsets.all(4).copyWith(top: 32, bottom: 32),
          color: Colors.white70,
          child: Column(children: [
            Text('(child widget)'),
            Text(
              '${model.counterValue}',
              style: Theme.of(context).textTheme.display1,
            ),
            ButtonBar(children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => model.incrementCounter(),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => model.decrementCounter(),
              ),
            ])
          ]),
        );
      },
    );
  }
}

class _MyState extends Model {
  int _count = 0;
  int get counterValue => _count;

  void incrementCounter() {
    _count++;
    notifyListeners();
  }

  void decrementCounter() {
    _count--;
    notifyListeners();
  }
}
