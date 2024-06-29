import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_food/model/model_food.dart';
import 'package:project_food/screens/order_detail.dart';
import 'package:project_food/utils/ip.dart';
import 'package:project_food/screens/profile_screen.dart'; // Import the ProfileScreen

import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<List<DatumFood>?> _futureFavoriteKonten;
  List<DatumFood> _favoriteKontenList = [];
  String? username, id;

  @override
  void initState() {
    super.initState();
    _futureFavoriteKonten = getSession().then((value) => getFavoriteKonten());
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("username") ?? '';
      id = pref.getString("id") ?? '';
    });
  }

  Future<List<DatumFood>?> getFavoriteKonten() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? idUser = pref.getString("id");

      if (idUser == null) {
        throw Exception('User ID is null');
      }

      var url = Uri.parse('$ip/getOrder.php?id_user=$id');
      http.Response res = await http.get(url);

      if (res.statusCode == 200) {
        var jsonResponse = json.decode(res.body);

        if (jsonResponse['isSuccess']) {
          List<DatumFood> favoriteKonten = [];

          for (var item in jsonResponse['data']) {
            DatumFood konten = DatumFood.fromJson(item);
            favoriteKonten.add(konten);
          }

          return favoriteKonten;
        } else {
          throw Exception(jsonResponse['message']);
        }
      } else {
        throw Exception('Failed to load favorite contents');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Makanan yg dipesan',
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFFDC5F00),
      ),
      body: FutureBuilder(
        future: _futureFavoriteKonten,
        builder:
            (BuildContext context, AsyncSnapshot<List<DatumFood>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            _favoriteKontenList = snapshot.data!;
            return ListView.builder(
              itemCount: _favoriteKontenList.length,
              itemBuilder: (context, index) {
                DatumFood konten = _favoriteKontenList[index];
                String imageUrl = '$ip/gambar_food/${konten.gambarFood ?? ''}';

                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to ProfileScreen when the card is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetail(),
                        ),
                      );
                    },
                    child: Card(
                      color: Color(0xFFEEEEEE),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          konten.namaFood,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF373A40),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          konten.keterangan,
                          maxLines: 2,
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Tidak ada makanan yg dipesan.'));
          }
        },
      ),
    );
  }
}
