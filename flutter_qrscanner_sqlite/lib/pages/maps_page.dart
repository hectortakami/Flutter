import 'package:flutter/material.dart';
import 'package:flutter_qrscanner_sqlite/providers/db_provider.dart';
import 'package:provider/provider.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DBProvider>(context);

    return ListView.builder(
      itemCount: dbProvider.registers.length,
      itemBuilder: (_, idx) => ListTile(
        leading: Icon(Icons.location_on),
        title: Text('Map ${dbProvider.registers[idx].id}'),
        subtitle: Text('${dbProvider.registers[idx].value}'),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () => {print('clicked')},
      ),
    );
  }
}
