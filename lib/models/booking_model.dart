class BookingModel {
  final String? name;
  final String? description;
  final String? type;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? totalPrice;
  final List<String> images;
  final List<String> facilities;

  BookingModel({
    this.name,
    this.description,
    this.type,
    this.startDate,
    this.endDate,
    this.totalPrice,
    this.images = const [],
    this.facilities = const [],
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      name: json['name'],
      description: json['description'],
      type: json['type'],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      totalPrice: json['totalPrice'],
      images: (json['images'] as List<dynamic>? ?? []).cast<String>(),
      facilities: (json['facilities'] as List<dynamic>? ?? []).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'type': type,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'totalPrice': totalPrice,
      'images': images,
      'facilities': facilities,
    };
  }
}
