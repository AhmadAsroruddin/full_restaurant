import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/models/restaurant.dart';
import 'package:restaurant_api/provider/restaurantDetail_provider.dart';
import 'package:restaurant_api/screens/detail_page.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: Hero(
            tag: restaurant.pictureId,
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
              width: 100,
            ),
          ),
          title: Text(restaurant.name),
          subtitle: Text(restaurant.city),
          trailing: Text(restaurant.rating.toString()),
          onTap: () {
            Provider.of<RestaurantDetailProvider>(context, listen: false)
                .fetchAllDetail(restaurant.id);
            Navigator.pushNamed(context, DetailPage.routeName,
                arguments: restaurant.id);
          }),
    );
  }
}
