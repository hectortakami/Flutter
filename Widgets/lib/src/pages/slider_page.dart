import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double sliderValue = 150.0;
  bool checkboxValue = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Slider'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(
                size: sliderValue,
              ),
              SizedBox(
                height: 50.0,
              ),
              createSlider(),
              Text(
                  'Image Size: ${sliderValue.toInt()}x${sliderValue.toInt()} px'),
              SizedBox(
                height: 50.0,
              ),
              createCheckbox(),
              createSwitch()
            ],
          ),
        ),
      ),
    );
  }

  Widget createSlider() {
    return Slider(
      value: sliderValue,
      min: 10.0,
      max: 300.0,
      onChanged: checkboxValue
          ? (value) {
              // print(value);
              setState(() {
                sliderValue = value;
              });
            }
          : null,
      activeColor: Colors.indigo,
      label: 'Size: $sliderValue px',
      // divisions: 10,
    );
  }

  Widget createCheckbox() {
    return CheckboxListTile(
        activeColor: Colors.lightBlue,
        title: Text(checkboxValue ? 'Slider Enabled' : 'Slider Disabled'),
        value: checkboxValue,
        onChanged: (checked) {
          setState(() {
            checkboxValue = checked!;
          });
        });
  }

  Widget createSwitch() {
    return SwitchListTile(
        activeColor: Colors.lightGreen,
        inactiveThumbColor: Colors.red,
        title: Text(checkboxValue ? 'Slider Enabled' : 'Slider Disabled'),
        value: checkboxValue,
        onChanged: (checked) {
          setState(() {
            checkboxValue = checked;
          });
        });
  }
}
