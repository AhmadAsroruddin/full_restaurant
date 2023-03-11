import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_api/provider/restaurant_provider.dart';
import 'package:restaurant_api/widgets/restaurant_card.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        body: Consumer<RestaurantProvider>(
          builder: (context, value, _) {
            if (value.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (value.state == ResultState.hasData) {
              return ListView.builder(
                itemCount: value.result.restaurants.length,
                itemBuilder: ((context, index) {
                  var restaurant = value.result.restaurants[index];
                  return RestaurantCard(restaurant: restaurant);
                }),
              );
            } else if (value.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(value.message),
                ),
              );
            } else if (value.state == ResultState.error) {
              return Center(
                child: Material(
                  child: Text(value.message),
                ),
              );
            } else {
              return const Center(
                child: Material(
                  child: Text(''),
                ),
              );
            }
          },
        ),
      );
    } catch (e) {
      return Text(e.toString());
    }
  }
}
