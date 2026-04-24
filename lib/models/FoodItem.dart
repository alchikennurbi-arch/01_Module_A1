class Fooditem {
  final String name, price, remark, type_id, image_url;
  String status;
  int count;
  final double score;

  Fooditem({
    this.count = 0,
    required this.image_url,
    required this.name,
    required this.price,
    required this.remark,
    required this.score,
    this.status = "Order placed",
    required this.type_id,
  });

  factory Fooditem.fromJson(Map<String, dynamic> json) {
    return Fooditem(
      image_url: json["image_url"] ?? "",
      name: json["name"] ?? "",
      price: json["price"] ?? "",
      remark: json["remark"] ?? "",
      score: double.parse(json["score"] ?? ""),
      type_id: json["type_id"] ?? "",
    );
  }
}
