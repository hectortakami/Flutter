import 'package:flutter/material.dart';

class _HomeState extends State<HomePage> {
  final _textStyle = new TextStyle(fontSize: 25);
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo!'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Counter', style: _textStyle),
              Text(
                '$_counter',
                style: _textStyle,
              )
            ],
          ),
        ),
        floatingActionButton: _createFABs());
  }

  Widget _createFABs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 30,
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() => _counter = 0);
          },
          child: Icon(Icons.close),
        ),
        Expanded(
          child: SizedBox(),
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() => _counter--);
          },
          child: Icon(Icons.remove),
          backgroundColor: Colors.red,
        ),
        SizedBox(
          width: 30,
        ),
        FloatingActionButton(
          onPressed: () {
            setState(() => _counter++);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return _HomeState();
  }
}
