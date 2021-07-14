import 'package:flutter/material.dart';

class ScrollDesignPage extends StatelessWidget {
  final boxDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
        0.5,
        0.5
      ],
          colors: [
        Color(0xff7FEDCA),
        Color(0xff30bad6),
      ]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: boxDecoration,
      child: PageView(
        // Disables the bouncing effect when holding the scroll up or down
        // physics: ClampingScrollPhysics(),

        scrollDirection: Axis.vertical,
        children: [ScrollPageOne(), ScrollPageTwo()],
      ),
    ));
  }
}

class ScrollPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff30BAD6),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Welcome!', style: TextStyle(fontSize: 25)),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
          ),
        ),
      ),
    );
  }
}

class ScrollPageOne extends StatelessWidget {
  var textStyle = TextStyle(
      fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        SafeArea(
          bottom: false,
          child: Container(
            margin: EdgeInsets.only(top: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '11°',
                  style: textStyle,
                ),
                Text(
                  'Monday',
                  style: textStyle,
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.expand_more,
                  size: 100,
                  color: Colors.white,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff30BAD6),
        alignment: Alignment.topCenter,
        height: double.infinity,
        child: Image(image: AssetImage('assets/scroll-1.png')));
  }
}
