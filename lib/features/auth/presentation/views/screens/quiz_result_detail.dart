import 'package:flutter/material.dart';
import 'package:quiz_app/core/helpers.dart';
import 'package:quiz_app/features/quiz/data/model/question_model.dart';
import 'package:quiz_app/features/quiz/presentation/views/widgets/options_container.dart';
import 'package:quiz_app/utils/utils.dart';

class QuizResultDetail extends StatefulWidget {
  const QuizResultDetail({
    super.key,
    required this.userAnswerList,
  });

  final List<QuestionModel> userAnswerList;

  @override
  State<QuizResultDetail> createState() => _QuizResultDetailState();
}

class _QuizResultDetailState extends State<QuizResultDetail> {
  List<Color> optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  List<bool> buttonStates = List<bool>.filled(4, true);
  int quesionIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${quesionIndex + 1}/10"),
        centerTitle: true,
        leadingWidth: getWidth(context) * 0.13,
        leading: InkWell(
          onTap: () {
            if (quesionIndex == 0) {
              pop(context);
            } else {
              setState(() {
                quesionIndex--;
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
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
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
                    widget.userAnswerList[quesionIndex].questionText.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.userAnswerList[quesionIndex].options.length,
              itemBuilder: (context, index) {
                List<String> options = [
                  ...widget.userAnswerList[quesionIndex].options
                ];
                // options.shuffle();
                return options[index] ==
                        widget.userAnswerList[quesionIndex].correctAnswer
                    ? OptionsContainer(
                        title: options[index],
                        backgroundColor: Colors.green,
                        checkAnswereIcon: const Icon(Icons.check_circle),
                      )
                    : options[index] ==
                            widget.userAnswerList[quesionIndex].userAnswer
                        ? OptionsContainer(
                            title: options[index],
                            backgroundColor: Colors.red,
                            checkAnswereIcon: const Icon(Icons.cancel),
                          )
                        : OptionsContainer(
                            title: options[index],
                            backgroundColor: optionsColor[index],
                            checkAnswereIcon: const Icon(Icons.cancel),
                          );
              },
            ),
          ),
          InkWell(
            onTap: nextQuestion,
            child: const ButtonWidget(
              title: "Next",
              backgroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void nextQuestion() {
    if (quesionIndex < 9) {
      setState(() {});
      quesionIndex++;
    } else {
      pop(context);
    }
  }
}
