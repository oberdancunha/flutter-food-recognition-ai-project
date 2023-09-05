import 'package:flutter/widgets.dart';

class MainImageWidget extends StatelessWidget {
  const MainImageWidget({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.65,
        child: Image.asset(
          'assets/images/background.png',
        ),
      );
}
