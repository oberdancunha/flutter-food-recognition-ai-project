import 'package:flutter/material.dart';

class ImageSourceOptionWidget extends StatelessWidget {
  final String image;
  final String title;
  final bool isSelected;

  const ImageSourceOptionWidget({
    required this.image,
    required this.title,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Card(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.12,
          width: MediaQuery.sizeOf(context).width * 0.45,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(image),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    fontSize: MediaQuery.sizeOf(context).width * 0.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
