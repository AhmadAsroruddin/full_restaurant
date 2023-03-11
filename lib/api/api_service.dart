import 'dart:io';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:restaurant_api/models/restaurantDetail.dart';
import 'dart:convert';

import '../models/restaurant.dart';
import 'api_exceptions.dart';

class ApiService {
  Duration timeOut = Duration(seconds: 35);
  Future<Welcome> topHeadlines(http.Client client) async {
    try {
      final response = await client
          .get(
            Uri.parse("https://restaurant-api.dicoding.dev/list"),
          )
          .timeout(timeOut);

      if (response.statusCode == 200) {
        return Welcome.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw ExceptionHandlers().getExceptionString(e);
    }
  }

  Future<RestaurantDetail> restaurantDetail(String id, http.Client client) async {
    try {
      final response = await client.get(
        Uri.parse(
            "https://restaurant-api.dicoding.dev/detail/$id"),
      );
      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to Load data");
      }
    } catch (e) {
      throw ExceptionHandlers().getExceptionString(e);
    }
  }

  Future<Searching> searching(String keyWord) async {
    try {
      final response = await http
          .get(
            Uri.parse("https://restaurant-api.dicoding.dev/search?q=$keyWord"),
          )
          .timeout(timeOut);
      if (response.statusCode == 200) {
        return Searching.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to load Data");
      }
    } catch (e) {
      throw ExceptionHandlers().getExceptionString(e);
    }
  }
}
