import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import 'package:restaurant_api/api/api_service.dart';
import 'package:restaurant_api/models/restaurantDetail.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService});

  late RestaurantDetail _results;
  late ResultState _state;
  String _message = "";

  String get message => _message;
  RestaurantDetail get result => _results;
  ResultState get state => _state;

  Future<dynamic> fetchAllDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final results = await apiService.restaurantDetail(id, http.Client());
      if (results.error) {
        _state = ResultState.noData;
        print("error");
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        print("berhasil");
        notifyListeners();
        return _results = results;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
