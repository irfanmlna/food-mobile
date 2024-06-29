import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_food/model/model_food.dart';
import 'package:project_food/screens/food_detail_screen.dart';
import 'package:project_food/utils/ip.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  TextEditingController txtcari = TextEditingController();
  late Future<List<DatumFood>?> _futureFood;
  late List<DatumFood> _foodList = [];
  late List<DatumFood> _originalFoodList = [];
  String? username, id;

  @override
  void initState() {
    super.initState();
    _futureFood = getFood();
    getSession();
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("username") ?? '';
      id = pref.getString("id") ?? '';
    });
  }

  Future<List<DatumFood>?> getFood() async {
    try {
      http.Response res = await http.get(Uri.parse('$ip/getFood.php'));
      return modelFoodFromJson(res.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }

  Future<void> addToFavorite(String idFood) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String idUser = pref.getString("id") ?? ''; // Assuming you have id_user stored in SharedPreferences

    var url = Uri.parse('$ip/addOrder.php');
    var response = await http.post(url, body: {
      'id_user': idUser,
      'id_food': idFood,
    });

    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['value'] == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Makanan berhasil ditambahkan ke pesanan')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal menambahkan Makanan ke pesanan')));
        }
      } catch (e) {
        print('Error parsing JSON: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Terjadi kesalahan saat menambahkan pesanan')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan saat menambahkan pesanan')));
    }
  }

  void _searchFood(String query) {
    setState(() {
      if (_originalFoodList.isEmpty) {
        _originalFoodList.addAll(_foodList);
      }

      if (query.isEmpty) {
        _foodList.clear();
        _foodList.addAll(_originalFoodList);
      } else {
        _foodList.clear();
        _foodList.addAll(_originalFoodList.where((food) =>
            food.namaFood!.toLowerCase().contains(query.toLowerCase())));
      }
    });
  }

  void _confirmAddToFavorite(String idFood) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menambahkan makanan ini ke pesanan?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop();
                addToFavorite(idFood);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Hi, ${username ?? ''}',
          style: TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFFDC5F00),
      ),
      body: Column(
        children: [
           const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: TextField(
              onChanged: _searchFood,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: _futureFood,
              builder: (BuildContext context,
                  AsyncSnapshot<List<DatumFood>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 41, 83, 154)));
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData) {
                  _foodList = snapshot.data!;
                  return ListView.builder(
                    itemCount: _foodList.length,
                    itemBuilder: (context, index) {
                      DatumFood food = _foodList[index];
                      String imageUrl =
                          '$ip/gambar_food/${food.gambarFood}';

                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FoodDetailScreen(food)),
                            );
                          },
                          child: Card(
                            color: Color(0xFFEEEEEE),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8), // Adjust the border radius as needed
                                child: Image.network(
                                  imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                '${food.namaFood}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF373A40),
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${food.keterangan}',
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _confirmAddToFavorite(food.id);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('Tidak ada data'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
