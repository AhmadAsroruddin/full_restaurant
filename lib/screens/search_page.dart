import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/provider/search_provider.dart';

import '../widgets/restaurant_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    // Provider.of<SearchProvider>(context, listen: false).fetchAllResult();
    // final a = Provider.of<SearchProvider>(context);
    String keys = _controller.text;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: "Mau makan apa?",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onSubmitted: (a) {
                Provider.of<SearchProvider>(context, listen: false)
                    .fetchAllResult(a);
              },
            ),
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (context, value, _) {
                  if (value.state == ResultState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (value.state == ResultState.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: value.result.restaurants.length,
                        itemBuilder: ((context, index) {
                          var restaurant = value.result.restaurants[index];
                          return RestaurantCard(restaurant: restaurant);
                        }),
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}
