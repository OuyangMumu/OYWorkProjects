/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class GridListExample extends StatelessWidget {
  const GridListExample({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      scrollDirection: Axis.horizontal,
      children: List.generate(100, (index) {
        return Center(
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
        );
      }),
    );
  }
}
