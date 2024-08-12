import 'package:flutter_riverpod/flutter_riverpod.dart';

final isAnsweredProvider = StateNotifierProvider<AnswerController, bool>((ref) {
  return AnswerController();
});

class AnswerController extends StateNotifier<bool> {
  AnswerController() : super(false);

  void setAnsweredTrue() {
    state = true;
  }

  void setAnsweredFalse() {
    state = false;
  }
}
