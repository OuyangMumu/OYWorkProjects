import 'package:flutter/material.dart';

class InheritedWidgetExample extends StatelessWidget {
  const InheritedWidgetExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: _MyDemoApp(),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  MyInheritedWidget({Key key, this.child, @required this.myDemoAppState})
      : super(key: key, child: child);

  final Widget child;
  final _MyDemoAppState myDemoAppState;

  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return this.myDemoAppState.counterValue !=
        oldWidget.myDemoAppState.counterValue;
  }
}

class _MyDemoApp extends StatefulWidget {
  _MyDemoApp({Key key}) : super(key: key);

  @override
  _MyDemoAppState createState() => _MyDemoAppState();
}

class _MyDemoAppState extends State<_MyDemoApp> {
  int _counter = 0;
  int get counterValue => _counter;

  void incrementCounter() => setState(() {
        _counter++;
      });

  void decrementCounter() => setState(() {
        _counter--;
      });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text("InheritedWidget allows efficient sharing of app's state down "
            "the widgets tree.\n\n"
            "In this example, the app's root widget is an InheritedWidget, "
            "so it's state is shared to the two `CounterAndButtons` widgets "
            "below. \n\n"
            "Clicking on child widget's button would update the root "
            "widget's counter.\n\n"
            "*Note*: Recommend using ScopedModel or BLoC for CHANGING parent's "
            "state from child widget.\n"),
        MyInheritedWidget(
          myDemoAppState: this,
          child: _AppRootWidget(),
        ),
      ],
    );
  }
}

class _AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootWidgetsState = MyInheritedWidget.of(context).myDemoAppState;
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          Text('(root widget)'),
          Text(
            '${rootWidgetsState.counterValue}',
            style: Theme.of(context).textTheme.display1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _CounterAndButton(),
              _CounterAndButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class _CounterAndButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ###4. Retrieve parent widget's state using the static of() function.
    final rootWidgetsState = MyInheritedWidget.of(context).myDemoAppState;
    return Card(
      margin: EdgeInsets.all(4.0).copyWith(bottom: 32.0),
      color: Colors.white70,
      child: Column(
        children: <Widget>[
          Text('(child widget)'),
          Text(
            '${rootWidgetsState.counterValue}',
            style: Theme.of(context).textTheme.display1,
          ),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => rootWidgetsState.incrementCounter(),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => rootWidgetsState.decrementCounter(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
