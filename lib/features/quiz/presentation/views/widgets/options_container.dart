import 'package:flutter/material.dart';

import 'package:quiz_app/core/helpers.dart';

class OptionsContainer extends StatelessWidget {
  const OptionsContainer({
    super.key,
    required this.title,
    this.checkAnswereIcon = const SizedBox.shrink(),
    this.backgroundColor = Colors.white,
  });
  final String title;
  final Widget? checkAnswereIcon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: getWidth(context) * 0.7,
            ),
            child: Text(
              title,
              // overflow: TextOverflow.ellipsis,
              // maxLines: 1,
              style: const TextStyle(),
            ),
          ),
          checkAnswereIcon ?? const SizedBox.shrink()
        ],
      ),
    );
  }
}
