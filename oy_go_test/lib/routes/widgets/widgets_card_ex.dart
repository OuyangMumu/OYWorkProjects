/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class CardExample extends StatefulWidget {
  const CardExample({Key key}) : super(key: key);

  @override
  _CardExampleState createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: <Widget>[
        Card(
          color: Colors.red,
          elevation: 10.0,
          child: Container(
            padding: EdgeInsets.all(10),
            height: 100,
            child: Row(
              children: <Widget>[Expanded(child: Text("Card 1"))],
            ),
          ),
        ),
        Card(
          color: Colors.green,
          margin: EdgeInsets.all(20),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
          child: Container(
            height: 100.0,
            child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Card 2 (with Inkwell effect on tap)"),
                      ),
                    ],
                  ),
                )),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text("SHARE"),
              onPressed: () {},
            ),
            FlatButton(
              child: Text("EXPLORE"),
              onPressed: () {},
            )
          ],
        ),
        Card(
          color: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.elliptical(30, 30),
          )),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 100,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("Card 3 (with custom border radius)"),
                )
              ],
            ),
          ),
        ),
        Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        child: Image.asset(
                      'res/images/material_design_4.jpg',
                      fit: BoxFit.cover,
                    )),
                    Positioned(
                        bottom: 0,
                        left: 16,
                        right: 16,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Card 4 (example)',
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(color: Colors.white, fontSize: 15),
                          ),
                        ))
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("SHARE"),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text("EXPLORE"),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
