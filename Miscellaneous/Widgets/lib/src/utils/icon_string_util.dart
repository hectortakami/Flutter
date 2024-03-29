import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'add_alert': Icons.add_alert,
  'accessibility': Icons.accessibility,
  'folder_open': Icons.folder_open,
  'donut_large': Icons.donut_large,
  'inputs': Icons.power_input_rounded,
  'slider': Icons.expand,
  'listview': Icons.list,
};

Icon getIcon(String name) => Icon(
      _icons[name],
      color: Colors.blue,
    );
