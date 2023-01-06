import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuchers_garage/screens/new_task.dart';
import 'package:wuchers_garage/screens/wucher/wucher_homepage.dart';
import 'package:wuchers_garage/screens/wucher/wucher_profile.dart';

class WucherPageNavigation extends StatefulWidget {
  const WucherPageNavigation({Key? key}) : super(key: key);
  static const wucherNav = 'wucher_navigation';

  @override
  State<WucherPageNavigation> createState() => _WucherPageNavigationState();
}

class _WucherPageNavigationState extends State<WucherPageNavigation> {
  //page navigation
  final List<Widget> _pages = [
    WucherHomepage(),
    const WucherProfile(),
  ];

  //handler to change active index
  int _activeIndex = 0;

  void _onTap(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorLight,
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),

        //add new task
        onPressed: () {
          Navigator.pushNamed(
            context,
            NewTaskScreen.newTask,
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        height: MediaQuery.of(context).size.height * 0.08,
        activeColor: Colors.white,
        inactiveColor: Colors.white70,
        iconSize: 25.0,
        icons: const [
          FontAwesomeIcons.list,
          Icons.person_outlined,
        ],
        activeIndex: _activeIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: _onTap,
      ),

      //page bodies
      body: _pages.elementAt(_activeIndex),
    );
  }
}
