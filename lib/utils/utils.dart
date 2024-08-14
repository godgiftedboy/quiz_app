import 'package:flutter/material.dart';
import 'package:quiz_app/core/helpers.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.title,
    this.backgroundColor = Colors.black,
  });
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: getWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

void keyBoardDismiss(BuildContext context) {
  return FocusScope.of(context).unfocus();
}

void pop(BuildContext context) {
  Navigator.pop(context);
}

//Navigations
void navigation(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (ctx) => widget));
}

pushReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (ctx) => widget,
    ),
  );
}

void pushAndRemoveUntil(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (ctx) => widget),
    (route) => false,
  );
}
