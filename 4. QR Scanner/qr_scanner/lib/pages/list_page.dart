import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/sql_provider.dart';
import 'package:qr_scanner/shared/url_launcher.dart';

class ListPage extends StatelessWidget {
  final String type;
  const ListPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sqlProvider = Provider.of<SQLProvider>(context);
    final scans = sqlProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.deepOrange),
        onDismissed: (_) => sqlProvider.removeByID(scans[i]),
        child: ListTile(
          leading: scans[i].type == 'geo'
              ? const Icon(Icons.place)
              : const Icon(Icons.open_in_new),
          title: Text(scans[i].value),
          subtitle: Text('SQL ID: ${scans[i].id}'),
          trailing: const Icon(Icons.arrow_right),
          onTap: () => {
            if (scans[i].type == 'http')
              {URLLauncher().launchURL(scans[i].value)}
            else
              {Navigator.pushNamed(context, 'map')}
          },
        ),
      ),
    );
  }
}
