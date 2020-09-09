import 'dart:convert';

class PaymentLoad {
  PaymentLoad({
    this.total,
    this.paymentType,
    this.currency,
  });

  Total total;
  List<PaymentType> paymentType;
  List<Currency> currency;

  factory PaymentLoad.fromRawJson(String str) =>
      PaymentLoad.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentLoad.fromJson(Map<String, dynamic> json) => PaymentLoad(
        total: Total.fromJson(json["total"]),
        paymentType: List<PaymentType>.from(
            json["payment_type"].map((x) => PaymentType.fromJson(x))),
        currency: List<Currency>.from(
            json["currency"].map((x) => Currency.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total.toJson(),
        "payment_type": List<dynamic>.from(paymentType.map((x) => x.toJson())),
        "currency": List<dynamic>.from(currency.map((x) => x.toJson())),
      };
}

class Currency {
  Currency({
    this.id,
    this.currency,
    this.rate,
    this.sign,
  });

  int id;
  String currency;
  String rate;
  String sign;

  factory Currency.fromRawJson(String str) =>
      Currency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        currency: json["currency"],
        rate: json["rate"],
        sign: json["sign"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "rate": rate,
        "sign": sign,
      };
}

class PaymentType {
  PaymentType({
    this.paymentTypeId,
    this.rateId,
  });

  int paymentTypeId;
  int rateId;

  factory PaymentType.fromRawJson(String str) =>
      PaymentType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
        paymentTypeId: json["payment_type_id"],
        rateId: json["rate_id"],
      );

  Map<String, dynamic> toJson() => {
        "payment_type_id": paymentTypeId,
        "rate_id": rateId,
      };
}

class Total {
  Total({
    this.grandTotalUs,
    this.grandTotalKh,
  });

  String grandTotalUs;
  String grandTotalKh;

  factory Total.fromRawJson(String str) => Total.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        grandTotalUs: json["grand_total_us"],
        grandTotalKh: json["grand_total_kh"],
      );

  Map<String, dynamic> toJson() => {
        "grand_total_us": grandTotalUs,
        "grand_total_kh": grandTotalKh,
      };
}
