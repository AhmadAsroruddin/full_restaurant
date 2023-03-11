import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_api/models/restaurantDetail.dart';
import '../lib/api/api_service.dart';
import 'restaurant_detail_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('Get restaurant detail by ID', () {
    test('will return more detail information about the restaurant by ID', () async {
      final client = MockClient();
      String id = "rqdv5juczeskfw1e867";

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client
              .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
          .thenAnswer((_) async => http.Response(''' 
              {
                "error" : false,
                "message" : "success",
                "restaurant" : {
                      "id": "rqdv5juczeskfw1e867",
                      "name": "Melting Pot",
                      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                      "city": "Medan",
                      "address": "Jln. Pandeglang no 19",
                      "pictureId": "14",
                      "categories": [
                          {
                              "name": "Italia"
                          },
                          {
                              "name": "Modern"
                          }
                      ],
                      "menus": {
                          "foods": [
                              {
                                  "name": "Paket rosemary"
                              },
                              {
                                  "name": "Toastie salmon"
                              }
                          ],
                          "drinks": [
                              {
                                  "name": "Es krim"
                              },
                              {
                                  "name": "Sirup"
                              }
                          ]
                      },
                      "rating": 4.2,
                      "customerReviews": [
                          {
                              "name": "Ahmad",
                              "review": "Tidak rekomendasi untuk pelajar!",
                              "date": "13 November 2019"
                          }
                      ]
                  }
              }  ''', 200));
      RestaurantDetail restaurant =
          await ApiService().restaurantDetail(id, client);
      expect(restaurant, isA<RestaurantDetail>());
    });
  });
}
