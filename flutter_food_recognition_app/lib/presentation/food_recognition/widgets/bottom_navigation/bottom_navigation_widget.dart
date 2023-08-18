import 'package:flutter/material.dart';

import 'bottom_navigation_item.dart';
import 'bottom_navigation_option.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  late List<BottomNavigationItem> _bottomNavigationBarItem;
  late int _bottomNavigationOptionIndex;

  @override
  void initState() {
    super.initState();
    _bottomNavigationBarItem = [
      BottomNavigationItem(title: 'Câmera', image: 'food_camera.png', callAction: () {}),
      BottomNavigationItem(title: 'Galeria', image: 'food_gallery.png', callAction: () {}),
    ];
    _bottomNavigationOptionIndex = -1;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.12,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int index = 0; index < _bottomNavigationBarItem.length; index++) ...[
              InkWell(
                child: BottomNavigationOption(
                  image: 'assets/images/${_bottomNavigationBarItem.elementAt(index).image}',
                  title: _bottomNavigationBarItem.elementAt(index).title,
                  isSelected: _bottomNavigationOptionIndex == index,
                ),
                onTap: () {
                  setState(() {
                    _bottomNavigationOptionIndex = index;
                  });
                  _bottomNavigationBarItem.elementAt(index).callAction();
                },
              ),
            ],
          ],
        ),
      );
}
