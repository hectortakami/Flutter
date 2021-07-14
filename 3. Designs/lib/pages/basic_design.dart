import 'package:flutter/material.dart';

class BasicDesignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(
            image: AssetImage('assets/image.jpg'),
          ),
          Title(),
          ButtonSection(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis velit felis, eleifend ac rutrum at, tristique quis libero. Cras semper sapien at lorem aliquam cursus. Aliquam convallis faucibus laoreet. Nullam vehicula, est quis volutpat viverra, ante quam ullamcorper lacus, vel dictum elit risus in nisi. Aenean vitae nulla ullamcorper, consectetur elit non, fringilla nunc. Nunc vitae odio suscipit, suscipit est ut, ultrices lorem. Quisque lorem leo, porttitor eget commodo eget, porttitor dapibus orci. Nunc tincidunt quam id enim imperdiet, vel viverra sem sagittis. Aenean lobortis sollicitudin viverra. Duis ut cursus urna.'),
          )
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(icon: Icons.call, text: 'CALL'),
          CustomButton(icon: Icons.send, text: 'ROUTE'),
          CustomButton(icon: Icons.share, text: 'SHARE'),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem Ipsum dolo ipsu dolem',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(color: Colors.black45),
              )
            ],
          ),
          Expanded(child: Container()),
          Icon(
            Icons.star,
            color: Colors.red,
          ),
          Text('41')
        ],
      ),
    );
  }
}
