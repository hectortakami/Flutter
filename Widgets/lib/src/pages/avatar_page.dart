import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Chip(
              backgroundColor: Colors.amber,
              label: Text('Lorem Ipsum'),
              avatar: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1497119146420-012f8fc80a3a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              child: Text('HT'),
              backgroundColor: Colors.green,
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1618316110288-5f13640cc38b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80'),
          placeholder: AssetImage('assets/fluid-loader.gif'),
        ),
      ),
    );
  }
}
