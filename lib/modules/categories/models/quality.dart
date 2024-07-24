class ItemQuality {
  final String name;
  final double price;

  ItemQuality({
    this.name = "",
    this.price = 0.0,
  });
  ItemQuality copyWith({
    String? name,
    double? price,
  }) {
    return ItemQuality(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}

class ItemQualityModel {
  final String name;
  final int price;

  ItemQualityModel({
    this.name = "",
    this.price = 0,
  });

  factory ItemQualityModel.fromJson(Map<String, dynamic> json) {
    return ItemQualityModel(
      name: json['name'] ?? "",
      price: json['price'] ?? 0,
    );
  }
}
