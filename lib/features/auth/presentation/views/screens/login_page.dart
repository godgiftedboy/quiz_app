import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/core/app_const.dart';
import 'package:quiz_app/core/db_client.dart';
import 'package:quiz_app/features/auth/presentation/views/screens/quiz_result.dart';
import 'package:quiz_app/features/auth/presentation/views/widgets/vaidation_mixin.dart';
import 'package:quiz_app/features/quiz/presentation/views/screens/quiz_page.dart';
import 'package:quiz_app/utils/utils.dart';

class LoginPage extends ConsumerWidget with ValidationMixin {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    List<String> scoreList = [];
    ref.watch(dbClientProvider).getUserList().then((value) {
      for (var i = 0; i < value.length; i++) {
        ref.watch(dbClientProvider).getScore(value[i]).then((value) {
          // setState(() {});
          scoreList = [...scoreList, value];
          print(scoreList);
        });
      }
    });
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
              child: Form(
                key: _formKey,
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
                      validator: validateName,
                      controller: nameController,
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
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.7,
                            color: AppConst.lightRedColor,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      ref.watch(dbClientProvider).getUserList().then((value) {
                        if (!value.contains(nameController.text)) {
                          if (context.mounted) {
                            navigation(
                                context,
                                QuizPage(
                                  username: nameController.text,
                                  // dbClient: ref.read(dbClientProvider),
                                ));
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Already Registered")));
                            navigation(
                                context,
                                QuizPage(
                                  username: nameController.text,
                                  // dbClient: ref.read(dbClientProvider),
                                ));
                          }
                        }
                      });
                    }
                  },
                  child: ButtonWidget(
                    title: "Start",
                    backgroundColor: AppConst.yellowColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref.watch(dbClientProvider).getUserList().then((value) {
                      print("object: $scoreList");
                      if (context.mounted) {
                        navigation(
                          context,
                          QuizResultPage(
                            userList: value,
                            scoreList: scoreList,
                          ),
                        );
                      }
                    });
                  },
                  child: const ButtonWidget(
                    title: "View Quiz Result",
                    backgroundColor: AppConst.lightGreyColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
