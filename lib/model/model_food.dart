import 'dart:convert';

ModelFood modelFoodFromJson(String str) =>
    ModelFood.fromJson(json.decode(str));

String modelFoodToJson(ModelFood data) => json.encode(data.toJson());

class ModelFood {
  bool isSuccess;
  String message;
  List<DatumFood> data;

  ModelFood({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelFood.fromJson(Map<String, dynamic> json) => ModelFood(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<DatumFood>.from(
            json["data"].map((x) => DatumFood.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumFood {
  String id;
  String namaFood;
  String keterangan;
  String gambarFood;

  DatumFood({
    required this.id,
    required this.namaFood,
    required this.keterangan,
    required this.gambarFood,
  });

  factory DatumFood.fromJson(Map<String, dynamic> json) => DatumFood(
        id: json["id"],
        namaFood: json["nama_food"],
        keterangan: json["keterangan"],
        gambarFood: json["gambar_food"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_food": namaFood,
        "keterangan": keterangan,
        "gambar_food": gambarFood,
      };
}
