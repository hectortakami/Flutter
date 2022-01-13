import 'package:flutter/material.dart';
import 'package:flutter_widgets/src/pages/alert_page.dart';
import 'package:flutter_widgets/src/pages/animated_container_page.dart';
import 'package:flutter_widgets/src/pages/avatar_page.dart';
import 'package:flutter_widgets/src/pages/card_page.dart';
import 'package:flutter_widgets/src/pages/home_page.dart';
import 'package:flutter_widgets/src/pages/inputs_page.dart';
import 'package:flutter_widgets/src/pages/listview_page.dart';
import 'package:flutter_widgets/src/pages/slider_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/': (BuildContext context) => HomePage(),
    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'animatedContainer': (BuildContext context) => AnimatedContainerPage(),
    'inputs': (BuildContext context) => InputsPage(),
    'slider': (BuildContext context) => SliderPage(),
    'listview': (BuildContext context) => ListViewPage(),
  };
}

Route<dynamic> Function(RouteSettings) manageInvalidRoutes() {
  return (settings) {
    print('INVALID ROUTE CALLED: "${settings.name}"');
    return MaterialPageRoute(builder: (context) => HomePage());
  };
}
