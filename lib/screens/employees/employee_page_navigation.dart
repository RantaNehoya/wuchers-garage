import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wuchers_garage/screens/employees/employee_homepage.dart';
import 'package:wuchers_garage/screens/employees/settings.dart';

class EmployeePageNavigation extends StatefulWidget {
  const EmployeePageNavigation({Key? key}) : super(key: key);
  static const employeeNav = 'employee_nav';

  @override
  State<EmployeePageNavigation> createState() => _EmployeePageNavigationState();
}

class _EmployeePageNavigationState extends State<EmployeePageNavigation> {
  //page navigation
  final List<Widget> _pages = [
    EmployeeHomepage(),
    const Settings(),
  ];

  //handler to change active index
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Theme.of(context).primaryColorDark,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.list,
              ),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: 'Settings',
            ),
          ],
          onTap: (position) {
            setState(() {
              _activeIndex = position;
            });
          },
          currentIndex: _activeIndex,
        ),

        //page bodies
        body: _pages.elementAt(_activeIndex),
      ),
    );
  }
}
