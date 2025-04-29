
class Recommendeds {
  int? id;
  String? code;
  String? name;
  String? nameEn;
  String? uom;
  double? price;
  String? description;
  int? stockQty;
  String? category;
  int? categoryId;
  List<dynamic>? images;

  Recommendeds({this.id, this.code, this.name, this.nameEn, this.uom, this.price, this.description, this.stockQty, this.category, this.categoryId, this.images});

  Recommendeds.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    name = json["name"];
    nameEn = json["nameEn"];
    uom = json["uom"];
    price = (json["price"] as num?)?.toDouble();
    description = json["description"];
    stockQty = (json["stockQty"] as num?)?.toInt();
    category = json["category"];
    categoryId = json["categoryId"];
    images = json["images"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["code"] = code;
    _data["name"] = name;
    _data["nameEn"] = nameEn;
    _data["uom"] = uom;
    _data["price"] = price;
    _data["description"] = description;
    _data["stockQty"] = stockQty;
    _data["category"] = category;
    _data["categoryId"] = categoryId;
    if (images != null) {
      _data["images"] = images;
    }
    return _data;
  }
}