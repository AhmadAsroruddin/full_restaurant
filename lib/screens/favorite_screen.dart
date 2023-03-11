import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/widgets/restaurant_card.dart';

import '../provider/db_provider.dart';
import '../models/restaurant.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Favorite"),
      ),
      body: SafeArea(
        child: Consumer<DBProvider>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.favorite.length,
              itemBuilder: (context, index) {
                final data = value.favorite[index];

                Restaurant resto = Restaurant(
                    id: data.restaurantId,
                    name: data.name,
                    description: "deskripsi",
                    pictureId: data.pictureId,
                    city: data.city,
                    rating: data.rating);
                return RestaurantCard(restaurant: resto);
              },
            );
          },
        ),
      ),
    );
  }
}
