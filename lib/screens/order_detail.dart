import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String? id, username, email, address;

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      email = pref.getString("email") ?? '';
      address = pref.getString("address") ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight - 8),
        child: AppBar(
          title: Text(
            'Detail pembeli',
            style: TextStyle(fontSize: 20, color: Color(0xFFEEEEEE)),
          ),
          backgroundColor: Color(0xFFDC5F00),
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(16),
          elevation: 4,
          color: Color(0xFFEEEEEE), // Ubah warna card di sini
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "lib/assets/account.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      _buildInfoItem("Name", username ?? ''),
                      SizedBox(height: 8),
                      _buildInfoItem("Email", email ?? ''),
                      SizedBox(height: 8),
                      _buildInfoItem("Address", address ?? ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

