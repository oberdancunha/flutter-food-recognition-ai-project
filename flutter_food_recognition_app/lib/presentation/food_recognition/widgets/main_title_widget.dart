import 'package:flutter/material.dart';

class MainTitleWidget extends StatelessWidget {
  const MainTitleWidget({super.key});

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
                child: Text(
                  'Meu Prato',
                  style: TextStyle(
                    fontFamily: 'GoodBoy',
                    fontSize: MediaQuery.sizeOf(context).width * 0.25,
                    color: Theme.of(context).colorScheme.tertiary,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.sizeOf(context).height * 0.045,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.65,
                child: Image.asset(
                  'assets/images/background.png',
                ),
              ),
            ),
          ),
        ],
      );
}
