import 'dart:convert';

class ListSaleData {
  ListSaleData({
    this.id,
    this.invoice,
    this.totalDisItem,
    this.subTotal,
    this.discountInvPercentage,
    this.discountInvDollars,
    this.grandTotal,
    this.payIn,
    this.returnKh,
    this.returnUS,
  });

  int id;
  String invoice;
  double totalDisItem;
  String subTotal;
  String discountInvPercentage;
  String discountInvDollars;
  String grandTotal;
  String payIn;
  String returnUS;
  String returnKh;

  factory ListSaleData.fromRawJson(String str) =>
      ListSaleData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListSaleData.fromJson(Map<String, dynamic> json) => ListSaleData(
        id: json["sale_master_id"],
        invoice: json["invoice"],
        totalDisItem: json["total_disItem"],
        subTotal: json["sub_total"],
        discountInvPercentage: json["discount_inv_percentage"],
        discountInvDollars: json["discount_inv_dollars"],
        grandTotal: json["grand_total"],
        payIn: json["payin"],
        returnUS: json["return_us"],
        returnKh: json["return_kh"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice": invoice,
        "total_disItem": totalDisItem,
        "sub_total": subTotal,
        "discount_inv_percentage": discountInvPercentage,
        "discount_inv_dollars": discountInvDollars,
        "grand_total": grandTotal,
        "payin": payIn,
        "return_us": returnUS,
        "return_kh": returnKh,
      };
}
