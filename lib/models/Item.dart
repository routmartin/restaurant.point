import 'dart:convert';

class Item {
  Item(
      {this.itemDetailId,
      this.itemName,
      this.price,
      this.image,
      this.qty,
      this.saleDetailId});

  int itemDetailId;
  String itemName;
  String price;
  String image;
  String qty;
  int saleDetailId;

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemDetailId: json["item_detail_id"],
        itemName: json["item_name"],
        price: json["price"],
        image: json["image"],
        qty: json["qty"],
        saleDetailId: json["sale_detail_id"],
      );

  Map<String, dynamic> toJson() => {
        "item_detail_id": itemDetailId,
        "item_name": itemName,
        "price": price,
        "image": image,
        "qty": qty,
        "sale_detail_id": saleDetailId,
      };
}
