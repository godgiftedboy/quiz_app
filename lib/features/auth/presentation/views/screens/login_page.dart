import 'package:flutter/material.dart';
import 'package:quiz_app/core/app_const.dart';
import 'package:quiz_app/utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConst.darkGreyColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    "QUIZ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter Your Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Waterflow Technology",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.7,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.7,
                          color: AppConst.lightGreyColor,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //     width: 0.5,
                      //     color: Colors.white,
                      //   ),
                      //   borderRadius: BorderRadius.circular(8),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: ButtonWidget(
                    title: "Start",
                    backgroundColor: AppConst.yellowColor,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const ButtonWidget(
                    title: "View Quiz Result",
                    backgroundColor: AppConst.lightGreyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
