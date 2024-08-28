import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/core/db_client.dart';
import 'package:quiz_app/core/helpers.dart';
import 'package:quiz_app/features/auth/presentation/views/screens/login_page.dart';
import 'package:quiz_app/utils/async_value_widget.dart';

import 'package:quiz_app/utils/utils.dart';

import '../../../quiz.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({
    super.key,
    required this.username,
  });

  final String username;

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  List<Color> optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  List<bool> buttonStates = List<bool>.filled(4, true);
  int quesionIndex = 0;
  int maxQuestionIndex = 0;
  //max index maintained to implement previous question visit functionality
  //so that user can answer again only after reaching the max question index

  int seconds = 30;
  int score = 0;

  Timer? timer;
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
          nextQuestion();
          ref.read(userAnswerProvider.notifier).addAnswerToList(QuestionModel(
              questionText: Question(text: "Times up"),
              correctAnswer: "null",
              incorrectAnswers: [],
              options: [
                "No question and answer stored",
                "You should answer to store the answer",
                "You didn't answer",
                "Please answer before timer end"
              ],
              userAnswer: "no answer"));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionControllerProvider);

    // print("Questions are loaded here: $questionList");

    final isAnswered = ref.watch(isAnsweredProvider);
    List<QuestionModel> answerList = ref.watch(userAnswerProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 213, 230, 239),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 213, 230, 239),
          title: Text("${quesionIndex + 1}/10"),
          centerTitle: true,
          leadingWidth: getWidth(context) * 0.3,
          leading: InkWell(
            onTap: () {
              if (quesionIndex == 0) {
                ref.watch(isAnsweredProvider.notifier).setAnsweredFalse();
                ref.invalidate(questionControllerProvider);
                ref.invalidate(userAnswerProvider);
                enableAllButtons();
                resetOptionsColor();
                pop(context);
              } else {
                ref.watch(isAnsweredProvider.notifier).setAnsweredTrue();
                if (maxQuestionIndex < quesionIndex) {
                  maxQuestionIndex = quesionIndex;
                }

                setState(() {
                  quesionIndex--;
                  timer!.cancel();

                  disableAllButtons();
                  resetOptionsColor();
                });
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  semanticLabel: "Previous",
                ),
                SizedBox(width: 2),
                Text("Previous"),
              ],
            ),
          ),
        ),
        body: MyAsyncValueWidget(
          value: questionState,
          data: (questionList) {
            return questionList.isEmpty
                ? const Center(child: Text("No questions available"))
                : Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          ...questionList.map((value) {
                            return const SizedBox.shrink();
                          }),
                          Container(
                            width: getWidth(context),
                            margin: const EdgeInsets.fromLTRB(20, 45, 20, 20),
                            padding: const EdgeInsets.all(12),
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                questionList[quesionIndex].questionText.text,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  height: 60,
                                  width: 60,
                                  child: CircularProgressIndicator(
                                    value: seconds / 30,
                                    backgroundColor: Colors.grey,
                                    strokeWidth: 6.0,
                                  ),
                                ),
                                Text(
                                  '${seconds}s',
                                  style: const TextStyle(fontSize: 24.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: questionList[quesionIndex].options.length,
                          itemBuilder: (context, index) {
                            List<String> options = [
                              ...questionList[quesionIndex].options
                            ];
                            // options.shuffle();
                            return InkWell(
                              onTap: buttonStates[
                                      index] //checking states to enable or disable buttons
                                  ? () {
                                      disableAllButtons();
                                      setState(() {
                                        if (options[index] !=
                                            questionList[quesionIndex]
                                                .correctAnswer) {
                                          //if tapped index is not correct answer
                                          //highting it with red as incorrect answer tapped
                                          optionsColor[index] = Colors.red;
                                        } else {
                                          score++;
                                        }
                                      });
                                      ref
                                          .watch(userAnswerProvider.notifier)
                                          .addAnswerToList(
                                            QuestionModel(
                                              questionText:
                                                  questionList[quesionIndex]
                                                      .questionText,
                                              correctAnswer:
                                                  questionList[quesionIndex]
                                                      .correctAnswer,
                                              incorrectAnswers:
                                                  questionList[quesionIndex]
                                                      .incorrectAnswers,
                                              options: options,
                                              userAnswer: options[index],
                                            ),
                                          );
                                      ref
                                          .watch(isAnsweredProvider.notifier)
                                          .setAnsweredTrue();
                                    }
                                  : null,
                              child: !isAnswered
                                  ? OptionsContainer(
                                      title: options[index],
                                    )
                                  : options[index] ==
                                          questionList[quesionIndex]
                                              .correctAnswer //assuming index 1 as correct answer
                                      ? OptionsContainer(
                                          title: options[index],
                                          backgroundColor: Colors.green,
                                          checkAnswereIcon: const Icon(
                                              Icons.check_circle_outlined),
                                        )
                                      : quesionIndex <= maxQuestionIndex &&
                                              answerList[quesionIndex]
                                                      .userAnswer ==
                                                  options[index]
                                          ? OptionsContainer(
                                              title: options[index],
                                              backgroundColor: Colors.red,
                                              checkAnswereIcon: const Icon(
                                                  Icons.cancel_outlined),
                                            )
                                          : OptionsContainer(
                                              title: options[index],
                                              backgroundColor:
                                                  optionsColor[index],
                                              checkAnswereIcon: const Icon(
                                                  Icons.cancel_outlined),
                                            ),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap:
                            ref.read(isAnsweredProvider) ? nextQuestion : null,
                        child: ButtonWidget(
                          title: "Next",
                          backgroundColor: ref.read(isAnsweredProvider)
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  void enableAllButtons() {
    setState(() {
      buttonStates = List<bool>.filled(buttonStates.length, true);
    });
  }

  void disableAllButtons() {
    setState(() {
      buttonStates = List<bool>.filled(buttonStates.length, false);
    });
  }

  void resetOptionsColor() {
    for (var i = 0; i < optionsColor.length; i++) {
      optionsColor[i] = Colors.white;
    }
  }

  void nextQuestion() async {
    ref.watch(isAnsweredProvider.notifier).setAnsweredTrue();

    // await Future.delayed(const Duration(seconds: 1));
    setState(() {});
    if (quesionIndex < 9) {
      quesionIndex++;
    } else {
      ref.watch(isAnsweredProvider.notifier).setAnsweredFalse();
      enableAllButtons();
      resetOptionsColor();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text("Quiz Completed! ${widget.username} Your Score: $score"),
        ),
      );

      //save user
      ref.read(dbClientProvider).saveUser(widget.username);

      //to save score
      ref.read(dbClientProvider).saveScore(widget.username, score.toString());

      //refresh questions on every round
      // ref.read(questionControllerProvider.notifier).resetState();
      // ref.read(questionControllerProvider.notifier).getAllQuestions();
      //-made it autodispose so no need to reset state manually

      //to save answers to shared prefs for result
      ref
          .read(dbClientProvider)
          .saveUserAnswers(widget.username, ref.read(userAnswerProvider));

      //reset state that store answers
      ref.read(userAnswerProvider.notifier).resetState();

      quesionIndex = 0;
      Navigator.of(context).popUntil((route) => false);
      navigation(context, LoginPage());
    }
    resetOptionsColor();

    timer!.cancel();
    if (quesionIndex > maxQuestionIndex) {
      ref.watch(isAnsweredProvider.notifier).setAnsweredFalse();

      seconds = 30;
      startTimer();

      enableAllButtons();
    }
  }
}
