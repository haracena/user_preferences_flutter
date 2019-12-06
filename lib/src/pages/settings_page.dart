import 'package:flutter/material.dart';
import 'package:user_preferences/src/share_prefs/user_preferences.dart';
import 'package:user_preferences/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _secondaryColor;
  int _genre;
  String _name = 'John';
  TextEditingController _textCtrl;

  final prefs = new UserPreferences();

  @override
  void initState() {
    super.initState();
    prefs.lastPage = SettingsPage.routeName;
    _genre = prefs.genre;
    _secondaryColor = prefs.secondaryColor;
    _textCtrl = TextEditingController(text: prefs.name);
  }

  _setSelectedRadio(int value) {
    prefs.genre = value;
    _genre = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Page'),
        backgroundColor: (prefs.secondaryColor) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Settings', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold)),
          ),
          Divider(),
          SwitchListTile(
            value: _secondaryColor,
            title: Text('Secondary Color'),
            onChanged: (value){
              setState(() {
                _secondaryColor = value;
                prefs.secondaryColor = value;
              });
            },
          ),
          RadioListTile(
            value: 1,
            title: Text('Male'),
            groupValue: _genre,
            onChanged: _setSelectedRadio,
          ),
          RadioListTile(
            value: 2,
            title: Text('Female'),
            groupValue: _genre,
            onChanged: _setSelectedRadio
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textCtrl,
              decoration: InputDecoration(
                labelText: 'Name',
                helperText: 'Person name using phone'
              ),
              onChanged: (value){
                prefs.name = value;
              },
            ),
          )
        ],
      )
    );
  }
}