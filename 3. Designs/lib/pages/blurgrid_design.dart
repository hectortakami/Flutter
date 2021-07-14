import 'dart:math';

import 'package:flutter/material.dart';

class BlurGridDesignPage extends StatelessWidget {
  const BlurGridDesignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
            child: Column(
              children: [TitleBar(), ButtonsGrid()],
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class ButtonsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          TransparentElement(
              text: 'General',
              color: Colors.blue,
              icon: Icons.grid_view_rounded),
          TransparentElement(
              text: 'Transport',
              color: Colors.deepPurple,
              icon: Icons.directions_bus)
        ]),
        TableRow(children: [
          TransparentElement(
              text: 'Shopping',
              color: Colors.purpleAccent,
              icon: Icons.shopping_bag),
          TransparentElement(
              text: 'Bills',
              color: Colors.deepOrangeAccent,
              icon: Icons.receipt)
        ]),
        TableRow(children: [
          TransparentElement(
              text: 'Entertainment',
              color: Colors.indigoAccent,
              icon: Icons.videocam),
          TransparentElement(
              text: 'Grocery', color: Colors.green, icon: Icons.restaurant)
        ]),
      ],
    );
  }
}

class TransparentElement extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const TransparentElement({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color.fromRGBO(62, 66, 107, 0.8),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, size: 35),
            radius: 30,
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(color: color, fontSize: 15),
          )
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xff2e305f), Color(0xff202333)],
        begin: Alignment.topCenter,
      ),
    );

    var pinkGradientBox = Positioned(
      top: -100,
      left: -50,
      child: Transform.rotate(
        angle: -pi / 5,
        child: Container(
          height: 360,
          width: 360,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(236, 98, 188, 1),
                Color.fromRGBO(241, 142, 172, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(80),
          ),
        ),
      ),
    );

    return Stack(children: [
      // Gradient Background Color
      Container(decoration: boxDecoration),
      // Custom Shape
      pinkGradientBox
    ]);
  }
}

class TitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Labore sint duis',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Labore sint duis mollit consequat adipisicing in dolore.',
            style: TextStyle(color: Colors.white, fontSize: 15),
          )
        ],
      ),
    ));
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color.fromRGBO(55, 57, 84, 1),
      selectedItemColor: Colors.pink,
      unselectedItemColor: Color.fromRGBO(116, 117, 152, 1),
      // Set the active index
      // currentIndex: 0,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle), label: ''),
      ],
    );
  }
}
