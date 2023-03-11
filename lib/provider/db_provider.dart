import 'package:flutter/material.dart';

import 'package:restaurant_api/database/database_helper.dart';
import 'package:restaurant_api/models/favorite.dart';
import '../provider/db_provider.dart';

class DBProvider extends ChangeNotifier {
  List<Favorite> _favorite = [];
  // ignore: prefer_final_fields
  List<String> _id = [];
  late DatabaseHelper _dbHelper;

  List<Favorite> get favorite => _favorite;
  List<String> get id => _id;

  DBProvider() {
    _dbHelper = DatabaseHelper();
    getAllData();
  }

  void addToIdList(String value) {
    _id.add(value);
    notifyListeners();
  }

  void deleteToIdList(String value) {
    _id.removeWhere((element) => element == value);
    notifyListeners();
  }

  void getAllData() async {
    _favorite = await _dbHelper.getFavorite();

    notifyListeners();
  }

  Future<void> addFavorite(Favorite fav) async {
    await _dbHelper.insert(fav);
    addToIdList(fav.restaurantId);
    getAllData();
  }

  Future<void> delete(String id) async {
    await _dbHelper.delete(id);
    deleteToIdList(id);
    getAllData();
  }
}
