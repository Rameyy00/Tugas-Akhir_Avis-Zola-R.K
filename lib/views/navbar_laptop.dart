import 'package:flutter/material.dart';
import 'package:project_1/views/profile_laptop.dart';
import 'package:project_1/views/trend_laptop.dart';
import 'package:project_1/views/laptop_view.dart'; 

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0; 

  static final List<Widget> _widgetOptions = <Widget>[
     LaptopView(), 
    TrendLaptop(),
    AkunLaptop()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _widgetOptions.elementAt(_selectedIndex), 

     
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.laptop,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trend Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, 
        selectedItemColor: Colors.indigo, 
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, 
      ),
    );
  }
}