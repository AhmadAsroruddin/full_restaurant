class Favorite {
  late int? id;
  late String name;
  late String restaurantId;
  late String city;
  late double rating;
  late String pictureId;

  Favorite(
      {this.id,
      required this.name,
      required this.restaurantId,
      required this.city,
      required this.rating,
      required this.pictureId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'restaurantId': restaurantId,
      'city': city,
      'rating': rating,
      'pictureId': pictureId
    };
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    restaurantId = map['restaurantId'];
    city = map['city'];
    rating = map['rating'];
    pictureId = map['pictureId'];
  }
}
