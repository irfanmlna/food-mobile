import 'dart:convert';

ModelOrder modelOrderFromJson(String str) => ModelOrder.fromJson(json.decode(str));

String modelOrderToJson(ModelOrder data) => json.encode(data.toJson());

class ModelOrder {
  bool isSuccess;
  String message;
  List<DatumOrder> data;

  ModelOrder({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelOrder.fromJson(Map<String, dynamic> json) => ModelOrder(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<DatumOrder>.from(json["data"].map((x) => DatumOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumOrder {
  String id;
  String namaFood; // Menyesuaikan dengan nama kolom di database ("nama_makanan" diganti menjadi "nama_food")
  String keterangan; // Menyesuaikan dengan nama kolom di database ("keterangan")
  String gambarFood; // Menyesuaikan dengan nama kolom di database ("gambar_makanan" diganti menjadi "gambar_food")

  DatumOrder({
    required this.id,
    required this.namaFood,
    required this.keterangan,
    required this.gambarFood,
  });

  factory DatumOrder.fromJson(Map<String, dynamic> json) => DatumOrder(
        id: json["id"],
        namaFood: json["nama_food"], // Diganti menjadi "nama_food"
        keterangan: json["keterangan"],
        gambarFood: json["gambar_food"], // Diganti menjadi "gambar_food"
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_food": namaFood, // Diganti menjadi "nama_food"
        "keterangan": keterangan,
        "gambar_food": gambarFood, // Diganti menjadi "gambar_food"
      };
}
