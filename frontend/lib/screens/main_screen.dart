import 'package:buildgreen/screens/area_personal_cliente.dart';
import 'package:buildgreen/screens/mapa_screen.dart';
import 'package:buildgreen/screens/signup_screen.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key ,}) : super(key: key);
  
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;
  PageController pageController = PageController();
  void onTapNavBar(int index){
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      backgroundColor: Colors.transparent,
      body: Container(
          child: PageView(
                controller: pageController,
                children: const <Widget>[
                  AreaPersonalCliente(),
                  SignUpScreen(),
                  MapaScreen(),
                ],
            ),
            decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.lightGreen,
                ],
              )
            ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: ""),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: onTapNavBar,
      ),
      
    );
    
  }
}