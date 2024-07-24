class PrintServiceModel {
  final String name;
  final int price;
  final List<String> images;

  PrintServiceModel({
    this.name = "",
    this.price = 0,
    this.images = const [],
  });

  factory PrintServiceModel.fromJson(Map<String, dynamic> json) {
    return PrintServiceModel(
      name: json['name'] ?? "",
      price: json['price'] ?? 0,
      images: json['images'] == null
          ? []
          : (json['images'] as List<dynamic>)
              .map((e) => e?.toString() ?? "")
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'images': images,
    };
  }
}
