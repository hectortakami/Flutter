import 'package:flutter/material.dart';
import 'package:flutter_widgets/src/providers/menu_provider.dart';
import 'package:flutter_widgets/src/utils/icon_string_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Widgets'),
        ),
        body: _createListView());
  }

  Widget _createListView() {
    return FutureBuilder(
      future: menuProvider.loadData(),
      initialData: [],
      builder: (context, AsyncSnapshot snapshot) {
        return ListView(children: _createListTales(snapshot.data, context));
      },
    );
  }

  List<Widget> _createListTales(List<dynamic> data, BuildContext context) {
    List<Widget> listTales = [];
    for (var option in data) {
      final tmp = ListTile(
        title: Text(option['text']),
        leading: getIcon(option['icon']),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.blue,
        ),
        onTap: () {
          // final route = MaterialPageRoute(builder: (context) => AlertPage());
          // Navigator.push(context, route);
          // Navigator.pop(context); // Go Back
          print(option['route']);
          Navigator.pushNamed(context, option['route']);
        },
      );
      listTales..add(tmp);
    }
    return listTales;
  }
}
