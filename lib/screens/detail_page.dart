import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

import 'package:restaurant_api/provider/restaurantDetail_provider.dart';
import '../models/restaurantDetail.dart';
import '../models/favorite.dart';
import '../provider/db_provider.dart';
import '../services/notify_helper.dart';
import '../main.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detailPage';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;
  var notificationHelper = NotificationHelper();

  @override
  void initState() {
    notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
    notificationHelper.configureDidReceiveLocalNotificationSubject(context, '');
    notificationHelper.configureSelectNotificationSubject(context, '');
    super.initState();
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    didReceiveLocalNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    String id = ModalRoute.of(context)?.settings.arguments as String;
    final dbProv = Provider.of<DBProvider>(context, listen: false).favorite;

    // for (int i = 0; i < dbProv.length; i++) {
    //   if (dbProv[i].restaurantId == id) {
    //     setState(() {
    //       isFavorite = true;
    //     });
    //   }
    // }

    if (Provider.of<DBProvider>(context, listen: false).id.contains(id)) {
      setState(() {
        isFavorite = !isFavorite;
      });
    }
    return Consumer<RestaurantDetailProvider>(
      builder: (context, value, child) {
        if (value.state == ResultState.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (value.state == ResultState.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(value.result.restaurant.name),
              actions: [
                !isFavorite
                    ? IconButton(
                        onPressed: () async {
                          final fav = Favorite(
                              name: value.result.restaurant.name,
                              restaurantId: value.result.restaurant.id,
                              city: value.result.restaurant.city,
                              rating: value.result.restaurant.rating,
                              pictureId: value.result.restaurant.pictureId);
                          await Provider.of<DBProvider>(context, listen: false)
                              .addFavorite(fav);
                          setState(() {
                            print("restarted");
                          });
                        },
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          Provider.of<DBProvider>(context, listen: false)
                              .delete(id);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      )
              ],
            ),
            body: Column(
              children: <Widget>[
                Container(
                  // margin: EdgeInsets.only(bottom: mediaQuery.height * 0.03),
                  width: double.infinity,
                  height: mediaQuery.height * 0.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://restaurant-api.dicoding.dev/images/large/${value.result.restaurant.pictureId}'),
                        fit: BoxFit.cover),
                  ),
                ),
                ListTile(
                  title: Text(
                    value.result.restaurant.name,
                    style: const TextStyle(fontSize: 30),
                  ),
                  trailing: Text(
                    " ${value.result.restaurant.rating}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value.result.restaurant.description,
                    textAlign: TextAlign.justify,
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                data(
                  title: "Foods",
                  e: value.result.restaurant.menus.foods,
                ),
                data(
                  title: "Beverages",
                  e: value.result.restaurant.menus.drinks,
                ),
              ],
            ),
          );
        } else if (value.state == ResultState.noData) {
          return Scaffold(
            body: Center(
              child: Material(
                child: Text(value.message),
              ),
            ),
          );
        } else if (value.state == ResultState.error) {
          return Scaffold(
            body: Center(
              child: Material(
                child: Text(value.message),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Material(
                child: Text(''),
              ),
            ),
          );
        }
      },
    );
  }
}

class data extends StatelessWidget {
  data({
    required this.e,
    required this.title,
    super.key,
  });

  List<Category> e;
  String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              title,
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: e.length,
              itemBuilder: ((context, index) {
                return Container(
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  child: Center(
                    child: Text(e[index].name),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
