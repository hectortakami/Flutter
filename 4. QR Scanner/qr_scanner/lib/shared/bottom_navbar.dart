// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    return BottomNavigationBar(
      currentIndex: uiProvider.navTabIndex,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.my_location),
          label: 'Maps',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.language),
          label: 'Directions',
        )
      ],
      onTap: (int selectedTabIndex) =>
          uiProvider.navTabIndex = selectedTabIndex,
    );
  }
}
