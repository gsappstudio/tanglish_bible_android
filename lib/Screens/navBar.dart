import 'package:flutter/material.dart';
import 'package:tanglis_bible_mobileapp/Screens/bibleIndex.dart';
import 'package:tanglis_bible_mobileapp/Screens/moreMenu.dart';
import 'package:tanglis_bible_mobileapp/Screens/notes.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:tanglis_bible_mobileapp/config/themedMode.dart';

import 'homePage.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    switch (_index) {
      case 0:
        child = HomeScreenPage();
        break;
        case 1:
        child = BibleIndex();
        break;
      case 2:
        child = Notes();
        break;
      case 3:
        child = MoreMenu();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backColor,
        title: Center(
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Images/bible.png', height: 35, width: 35,),
              SizedBox(width: 10,),
              Text(
                'Tanglish Bible',
                style: TextStyle(
                    color: Palette.primaryColor,
                    fontFamily: 'Proxima Nova',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Palette.backColor,
      body:
      DoubleBackToCloseApp(
    snackBar: const SnackBar(
    content: Text('Tap back again to leave'),),
        child: Column(
          children: [
            Expanded(
                child: SizedBox.expand(
              child: child,
            ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) {
          setState(() {
            _index = newIndex;
          });
        },
        currentIndex: _index,
        backgroundColor: Colors.black87,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.blue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.black87,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),

            backgroundColor: Colors.black87,
            label: 'Bible',
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.black87,

              icon: Icon(Icons.description), label: 'Notes'),

          BottomNavigationBarItem(
              backgroundColor: Colors.black87,
              icon: Icon(Icons.menu), label: 'More'),
        ],
      ),
    );
  }
}
