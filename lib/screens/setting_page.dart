import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../provider/scheduling_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // ignore: prefer_final_fields
  bool _setting = false;

  void setValue(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("notificationSetting", value);
  }

  void getValue() async {
    final prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool("notificationSetting") ?? false;
    setState(() {
      _setting = value;
    });
  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text("Reminder at 11 AM"),
            Switch(
                value: _setting,
                onChanged: (bool value) {
                  setState(() {
                    _setting = value;
                  });
                  Provider.of<SchedulingProvider>(context, listen: false)
                      .scheduleNotification(value);
                  setValue(value);
                })
          ],
        ),
      ),
    );
  }
}
