import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_food/screens/order_screen.dart';
import 'package:project_food/screens/food_screen.dart';
import 'package:project_food/screens/profile_screen.dart';


class Navbar extends StatefulWidget {
  final int  index;
  const Navbar({
    this.index = 0,
    super.key,});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    FoodScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Container(
          color: Color(0xFF373A40), // Ubah warna latar belakang
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: GNav(
              gap: 8,
              selectedIndex: _selectedIndex,
              onTabChange: _navigateBottomBar,
              padding: EdgeInsets.all(7),
              backgroundColor: Color(0xFF373A40), // Sesuaikan dengan warna latar belakang
              color: Colors.black, // Warna ikon
              activeColor: Colors.black, // Warna ikon aktif
              tabBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  iconColor: Color(0xFFEEEEEE),
                  text: '', // Hapus teks dengan mengatur nilai string kosong
                ),
                GButton(
                  icon: Icons.add,
                  iconColor: Color(0xFFEEEEEE),
                  text: '', // Hapus teks dengan mengatur nilai string kosong
                ),
                GButton(
                  icon: Icons.person_2_rounded,
                  iconColor: Color(0xFFEEEEEE),
                  text: '', // Hapus teks dengan mengatur nilai string kosong
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
