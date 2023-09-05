import 'package:flutter/material.dart';

import 'main_image_widget.dart';
import 'main_title_widget.dart';

class MainBodyWidget extends StatelessWidget {
  const MainBodyWidget({super.key});

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height * 0.075,
              left: MediaQuery.sizeOf(context).width * 0.045,
            ),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
              width: MediaQuery.sizeOf(context).width * 0.45,
              child: Align(
                alignment: Alignment.topLeft,
                child: MainTitleWidget(
                  fontSize: MediaQuery.sizeOf(context).width * 0.25,
                  fontColor: Theme.of(context).textTheme.titleLarge!.color!,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.sizeOf(context).height * 0.045,
            ),
            child: const Align(
              alignment: Alignment.bottomRight,
              child: MainImageWidget(),
            ),
          ),
        ],
      );
}
