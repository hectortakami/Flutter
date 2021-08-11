import 'package:flutter/material.dart';
import 'package:flutter_qrscanner_sqlite/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return BottomNavigationBar(
      onTap: (int i) => {uiProvider.menuOpt = i},
      selectedItemColor: Theme.of(context).primaryColor,
      currentIndex: uiProvider.menuOpt,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Maps'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'URLs'),
      ],
    );
  }
}
