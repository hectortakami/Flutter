import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Display Alert'),
          onPressed: () => _displayAlert(context),
          style: ElevatedButton.styleFrom(
              primary: Colors.blue, shape: StadiumBorder()),
        ),
      ),
    );
  }

  _displayAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Alert Title'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Lorem ipsum dolo ique'), FlutterLogo(size: 100)],
            ),
            actions: [
              ElevatedButton(onPressed: () {}, child: Text('Ok')),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
              ),
            ],
          );
        });
  }
}
