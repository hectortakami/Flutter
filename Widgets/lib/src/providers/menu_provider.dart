import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class MenuProvider {
  List<dynamic> menuOptions = [];

  MenuProvider();

  Future<List<dynamic>> loadData() async {
    final response = await rootBundle.loadString('data/menu_opts.json');
    Map dataMap = json.decode(response);
    menuOptions = dataMap['routes'];
    menuOptions.sort((a, b) => a['text'].compareTo(b['text']));
    return menuOptions;
  }
}

final menuProvider = new MenuProvider();
