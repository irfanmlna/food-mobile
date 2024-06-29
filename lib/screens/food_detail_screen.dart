import 'package:flutter/material.dart';
import 'package:project_food/model/model_food.dart';
import 'package:project_food/utils/ip.dart';

class FoodDetailScreen extends StatelessWidget {
  final DatumFood? data;

  const FoodDetailScreen(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEEEEEE),
      ),
      backgroundColor: Color(0xFFEEEEEE), // Set background color here
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '$ip/gambar_food/${data?.gambarFood}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.namaFood ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF373A40), // Title color
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              data?.keterangan ?? "",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
