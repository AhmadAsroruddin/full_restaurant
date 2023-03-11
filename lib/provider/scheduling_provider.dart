import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../services/backgroundService.dart';
import '../services/dateTime_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  Future<bool> scheduleNotification(bool value) async {
    if (value == true) {
      print('run');
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      print("deleted");
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
