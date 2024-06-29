import 'dart:convert';

OrderResponse orderResponseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
OrderResponse({
    required this.value,
    required this.message,
  });

  int value;
  String message;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
