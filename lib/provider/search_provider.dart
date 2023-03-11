import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../models/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  SearchProvider({required this.apiService}) {
    fetchAllResult(keyWords);
  }

  Searching _result = Searching(error: false, founded: 1, restaurants: []);
  String _message = '';
  String keyWords = "asd";
  late ResultState _state;
  bool circular = true;

  String get message => _message;
  Searching get result => _result;
  ResultState get state => _state;

  String get key => keyWords;

  void addKeyWord(String keyword) {
    keyWords = keyword;

    notifyListeners();
  }

  Future fetchAllResult(String keyword) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final results = await apiService.searching(keyword);

      if (results.restaurants.isEmpty) {
        _state = ResultState.noData;
        print("object");
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _result = results;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
