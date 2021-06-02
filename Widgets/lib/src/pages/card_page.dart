import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Cards')),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            _returnCardType1(),
            SizedBox(height: 30.0),
            _returnCardType2(),
            SizedBox(height: 30.0),
            _returnCardType1(),
            SizedBox(height: 30.0),
            _returnCardType2(),
            SizedBox(height: 30.0),
            _returnCardType1(),
            SizedBox(height: 30.0),
            _returnCardType2(),
            SizedBox(height: 30.0),
            _returnCardType1(),
            SizedBox(height: 30.0),
            _returnCardType2(),
            SizedBox(height: 30.0),
            _returnCardType1(),
            SizedBox(height: 30.0),
            _returnCardType2(),
            SizedBox(height: 30.0),
            _returnCardType1(),
            SizedBox(height: 30.0),
            _returnCardType2(),
            SizedBox(height: 30.0),
            _returnCardType1(),
            SizedBox(height: 30.0),
            _returnCardType2(),
            SizedBox(height: 30.0),
            _returnCardType1(),
            SizedBox(height: 30.0),
            _returnCardType2(),
            SizedBox(height: 30.0),
          ],
        ));
  }

  Widget _returnCardType1() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2.0,
      child: Column(
        children: [
          ListTile(
            title: Text('Card | Type 1'),
            subtitle: Text('lorem ipsum dolo ipsum ique'),
            leading: Icon(
              Icons.photo_album,
              color: Colors.blue,
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: Text('Ok'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Cancel'),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.red)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _returnCardType2() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 10.0,
      child: Column(
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/jar-loader.gif'),
            image: NetworkImage(
                'https://i.pinimg.com/originals/5e/65/20/5e6520289b44e11a9e74363c18ce3ee1.jpg'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 200,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Lorem ipsum dolo ipsum ique.'),
          )
        ],
      ),
    );
  }
}
