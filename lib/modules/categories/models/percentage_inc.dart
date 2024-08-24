class PercentageIncrease {
  final String name;
  final double price;

  PercentageIncrease({
    this.name = "",
    this.price = 0.0,
  });
  PercentageIncrease copyWith({
    String? name,
    double? price,
  }) {
    return PercentageIncrease(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}

class PercentageIncreaseModel {
  final String name;
  final int price;

  PercentageIncreaseModel({
    this.name = "",
    this.price = 0,
  });

  factory PercentageIncreaseModel.fromJson(Map<String, dynamic> json) {
    return PercentageIncreaseModel(
      name: json['name'] ?? "",
      price: json['price'] ?? 0,
    );
  }
}
