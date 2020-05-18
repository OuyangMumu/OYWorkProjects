/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class ExpansionTileExample extends StatelessWidget {
  const ExpansionTileExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
        return EntryItem(data[i]);
      },
      itemCount: data.length,
    );
  }
}

class Entry {
  const Entry(this.title, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
}

const List<Entry> data = <Entry>[
  Entry('Chapter A', [
    Entry('Section A0', [Entry('Section A0.1'), Entry('Section A0.2')]),
    Entry('Section A1'),
    Entry('Section A2', [Entry('Section A2.1'), Entry('Section A2.2')]),
  ]),
  Entry('Chapter B', [
    Entry('Section B0', [Entry('Section B0.1'), Entry('Section B0.2')]),
    Entry('Section B1'),
  ]),
  Entry('Chapter C', [
    Entry('Section C0', [Entry('Section C0.1'), Entry('Section C0.2')]),
  ]),
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final Entry entry;
  Widget buildTitles(Entry root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(root.title),
      );
    return ExpansionTile(
        title: Text(root.title),
        trailing: Image.asset(''),
        key: PageStorageKey<Entry>(root),
        children: root.children.map(buildTitles).toList());
  }

  @override
  Widget build(BuildContext context) {
    return buildTitles(entry);
  }
}
