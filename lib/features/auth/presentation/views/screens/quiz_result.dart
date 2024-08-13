import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/core/db_client.dart';
import 'package:quiz_app/features/auth/presentation/views/screens/login_page.dart';
import 'package:quiz_app/features/auth/presentation/views/screens/quiz_result_detail.dart';
import 'package:quiz_app/utils/utils.dart';

class QuizResultPage extends ConsumerStatefulWidget {
  const QuizResultPage(
      {super.key, required this.userList, required this.scoreList});
  final List<String> userList;

  final List<String> scoreList;

  @override
  ConsumerState<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends ConsumerState<QuizResultPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quiz Result Page",
          ),
        ),
        body: widget.userList.isEmpty
            ? const Center(child: Text("No user registered yet"))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "Click on item to view the result details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.userList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              ref
                                  .read(dbClientProvider)
                                  .getUserAnswers(widget.userList[index])
                                  .then((value) {
                                if (context.mounted) {
                                  navigation(context,
                                      QuizResultDetail(userAnswerList: value));
                                }
                              });
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(widget.userList[index]),
                                trailing: widget.scoreList.isEmpty
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "Score: ${widget.scoreList[index]}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ref.watch(dbClientProvider).removeAll();
                        Navigator.of(context).popUntil((route) => false);
                        navigation(context, LoginPage());
                      },
                      child: const ButtonWidget(title: "Clear"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
