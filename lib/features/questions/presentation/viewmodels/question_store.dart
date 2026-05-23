import 'dart:math';
import 'package:mobx/mobx.dart';
import '../../data/repositories/question_repository.dart';

part 'question_store.g.dart';

class QuestionStore = QuestionStoreBase with _$QuestionStore;

abstract class QuestionStoreBase with Store {
  final QuestionRepository _repository;

  QuestionStoreBase(this._repository) {
    _loadQuestions();
  }

  @observable
  ObservableMap<int, String> questions = ObservableMap<int, String>();

  @observable
  int? winnerIndex;

  @observable
  double targetRotationAngle = 0.0;

  @computed
  int get totalQuestions => questions.length;

  @action
  Future<void> _loadQuestions() async {
    final list = _repository.getQuestions();
    questions.clear();
    for (var q in list) {
      questions[q.id] = q.text;
    }
  }

  @action
  Future<void> addQuestion(String text) async {
    await _repository.addQuestion(text);
    await _loadQuestions();
  }

  @action
  Future<void> deleteQuestion(int id) async {
    await _repository.deleteQuestion(id);
    await _loadQuestions();
  }

  @action
  void drawWinner() {
    if (totalQuestions == 0) return;
    final random = Random();
    winnerIndex = random.nextInt(totalQuestions);

    final sectorAngle = (2 * pi) / totalQuestions;
    final centerOfWinnerSlice = (winnerIndex! * sectorAngle) + (sectorAngle / 2);

    targetRotationAngle = -centerOfWinnerSlice;
  }
}
