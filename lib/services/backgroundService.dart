import 'dart:ui';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_api/api/api_service.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import './notify_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');

    final NotificationHelper notif = NotificationHelper();
    var restaurantList = await ApiService().topHeadlines(http.Client());
    var restaurant = restaurantList.restaurants.toList();

    var randomNumber = Random().nextInt(restaurant.length);
    var randomRestaurant = restaurant[randomNumber];

    await notif.showNotification(flutterLocalNotificationsPlugin,
        randomRestaurant.city, randomRestaurant.name);
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
