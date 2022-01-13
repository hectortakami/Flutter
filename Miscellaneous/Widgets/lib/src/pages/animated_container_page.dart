import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  late Timer t;
  var play = false;
  IconData _fabIcon = Icons.play_arrow;

  var _width = 50.0;
  var _height = 50.0;
  Color _color = Colors.blue;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Animated Container'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: _color,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_fabIcon),
        onPressed: () => _modify(),
      ),
    ));
  }

  _modify() {
    play = !play;
    if (play) {
      setState(() => _fabIcon = Icons.pause);
      t = Timer.periodic(
          Duration(milliseconds: 1000), (_) => _modifyContainer());
    } else {
      setState(() {
        _fabIcon = Icons.play_arrow;
      });
      t.cancel();
    }
  }

  _modifyContainer() {
    setState(() {
      final random = Random();
      _width = random.nextInt(300).toDouble();
      _height = random.nextInt(300).toDouble();
      _color = Color.fromRGBO(
          random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
      _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
    });
  }
}
