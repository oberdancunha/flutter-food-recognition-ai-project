import 'package:flutter/material.dart';

import 'widgets/bottom_navigation/bottom_navigation_widget.dart';
import 'widgets/main_title_widget.dart';

class FoodRecognitionPage extends StatelessWidget {
  const FoodRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: const MainTitleWidget(),
          ),
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.all(10),
          child: BottomNavigationWidget(),
        ),
      );
}
