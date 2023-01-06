import 'package:flutter/material.dart';

class GarageAppBar extends StatelessWidget with PreferredSizeWidget {
  final List<String> tabLabels;

  const GarageAppBar({
    Key? key,
    required this.tabLabels,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return AppBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        'Work List',
        style: TextStyle(
          fontSize: mediaQuery.textScaleFactor * 25.0,
        ),
      ),
      bottom: TabBar(
          tabs: List.generate(tabLabels.length, (index) {
        return Tab(
          child: Text(
            tabLabels[index],
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      })),
    );
  }
}
