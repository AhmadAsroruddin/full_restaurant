import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;

import '../api/api_service.dart';
import '../models/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  Welcome _result =
      Welcome(error: false, message: 'message', count: 1, restaurants: []);
  late ResultState _state;
  String _message = '';

  String get message => _message;
  Welcome get result => _result;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.topHeadlines(http.Client());
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _result = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
