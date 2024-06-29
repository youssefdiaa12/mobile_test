import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  double _volume = 50.0;

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  void _changeVolume(double value) {
    setState(() {
      _volume = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SwitchListTile(
              title: Text('Notifications'),
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
            ),
            SizedBox(height: 20),
            Text('Volume'),
            Slider(
              value: _volume,
              min: 0,
              max: 100,
              divisions: 10,
              onChanged: _changeVolume,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // إضافة المزيد من الإعدادات هنا
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
