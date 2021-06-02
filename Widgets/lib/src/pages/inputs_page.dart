import 'package:flutter/material.dart';

class InputsPage extends StatefulWidget {
  @override
  _InputsPageState createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  String str = '';
  String email = '';
  String password = '';
  String date = '';
  TextEditingController _datePickerController = new TextEditingController();

  String selectedOption = 'Mercury';
  List optionList = [
    'Mercury',
    'Venus',
    'Earth',
    'Mars',
    'Jupiter',
    'Saturn',
    'Uranus',
    'Neptune',
    'Pluto'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inputs'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          children: [
            createDropDown(),
            SizedBox(height: 30),
            createTextField(),
            Divider(),
            Text('Text Field: $str'),
            SizedBox(height: 30),
            createEmailField(),
            Divider(),
            Text('Email Field: $email'),
            SizedBox(height: 30),
            createPasswordField(),
            Divider(),
            Text('Clear Password: $password'),
            SizedBox(height: 30),
            createDatePicker(context),
            Divider(),
            Text('Date selected: $date'),
          ],
        ));
  }

  createTextField() {
    return TextField(
        // autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            counter: Text('Number of chars: ${str.length}'),
            hintText: 'This is a placehorder...',
            labelText: 'Text Field',
            helperText: 'System keyboard theme',
            suffixIcon: Icon(Icons.accessibility),
            icon: Icon(Icons.account_circle)),
        onChanged: (value) {
          setState(() {
            str = value;
          });
        });
  }

  createEmailField() {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        keyboardAppearance: Brightness.dark,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: 'This is a placehorder...',
            labelText: 'Email Field',
            helperText: 'Dark keyboard',
            suffixIcon: Icon(Icons.alternate_email),
            icon: Icon(Icons.email)),
        onChanged: (value) {
          setState(() => email = value);
        });
  }

  createPasswordField() {
    return TextField(
        obscureText: true,
        keyboardAppearance: Brightness.light,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: 'This is a placehorder...',
            labelText: 'Password Field',
            helperText: 'Light keyboard',
            suffixIcon: Icon(Icons.lock),
            icon: Icon(Icons.vpn_key)),
        onChanged: (value) {
          setState(() => password = value);
        });
  }

  createDatePicker(BuildContext context) {
    return TextField(
        controller: _datePickerController,
        enableInteractiveSelection: false,
        keyboardAppearance: Brightness.light,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText: 'Date Picker',
            helperText: 'This is a helper text',
            suffixIcon: Icon(Icons.date_range),
            icon: Icon(Icons.calendar_today)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        });
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2025),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        date = picked.toString();
        _datePickerController.text = date;
      });
    }
  }

  createDropDown() {
    return Row(
      children: [
        Icon(Icons.select_all),
        SizedBox(
          width: 30,
        ),
        DropdownButton(
          value: selectedOption,
          items: _setDropdownMenuItems(),
          onChanged: (selected) {
            print('DropdownButton: $selected');
            setState(() {
              selectedOption = selected.toString();
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _setDropdownMenuItems() {
    List<DropdownMenuItem<String>> options = [];
    for (var option in optionList) {
      options.add(DropdownMenuItem(
        child: Text(option),
        value: option,
      ));
    }
    return options;
  }
}
