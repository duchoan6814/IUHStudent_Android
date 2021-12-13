import 'package:flutter/material.dart';
import 'screens.dart';

class MainScreeen extends StatefulWidget {
  const MainScreeen({Key? key}) : super(key: key);

  @override
  _MainScreeenState createState() => _MainScreeenState();
}

class _MainScreeenState extends State<MainScreeen> {
  int currentScreen = 0;

  final screens = [
    const HomeScreen(),
    const ScheduleScreen(),
    const ResultScreen(),
    const RegisterObjectScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child: screens[currentScreen]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() {
          currentScreen = index;
        }),
        currentIndex: currentScreen,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Lịch học"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart), label: "Kết quả"),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration), label: "DKHP"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
