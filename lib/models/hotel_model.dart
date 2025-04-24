import 'package:admin_panel/models/review_model.dart';

class HotelModel {
  String? id;
  final String name;
  final String description;
  final String address;
  final List<String> images;
  final List<String> facilities;
  final List<String> types;
  final Map<String, ReviewModel> reviews;
  final int price;
  final double rating;

  HotelModel({
    this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.images,
    required this.facilities,
    required this.types,
    required this.reviews,
    required this.price,
    required this.rating,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    try {
      final reviewData = json['review'] as Map<String, dynamic>? ?? {};

      final reviews = reviewData.map((key, value) {
        return MapEntry(key, ReviewModel.fromJson(value));
      });

      return HotelModel(
        id: json['id'],
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        address: json['address'] ?? '',
        images: List<String>.from(json['image'] ?? []),
        facilities: List<String>.from(json['facilities'] ?? []),
        types: List<String>.from(json['type'] ?? []),
        reviews: reviews,
        price: (json['price'] as num?)?.toInt() ?? 0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      );
    } catch (e) {
      print("fromjsonda error: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    final reviewMap = {
      for (var entry in reviews.entries) entry.key: entry.value.toJson(),
    };

    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'image': images,
      'facilities': facilities,
      'type': types,
      'review': reviewMap,
      'price': price,
      'rating': rating,
    };
  }

  HotelModel copyWith({
    String? id,
    String? name,
    String? description,
    String? address,
    List<String>? images,
    List<String>? facilities,
    List<String>? types,
    Map<String, ReviewModel>? reviews,
    int? price,
    double? rating,
  }) {
    return HotelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      images: images ?? this.images,
      facilities: facilities ?? this.facilities,
      types: types ?? this.types,
      reviews: reviews ?? this.reviews,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }
}
