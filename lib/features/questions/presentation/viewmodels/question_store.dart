import 'dart:math';

import 'package:mobx/mobx.dart';

import '../../../../core/services/audio_service.dart';
import '../../data/repositories/question_repository.dart';

part 'question_store.g.dart';

class QuestionStore = QuestionStoreBase with _$QuestionStore;

abstract class QuestionStoreBase with Store {
  final QuestionRepository _repository;
  final AudioService _audioService;

  QuestionStoreBase(this._repository, this._audioService) {
    _loadQuestions();
  }

  @observable
  ObservableMap<int, String> questions = ObservableMap<int, String>();

  @observable
  int? winnerIndex;

  @observable
  double targetRotationAngle = 0.0;

  @observable
  double currentRotation = 0.0;

  @computed
  int get totalQuestions => questions.length;

  @computed
  List<int> get sortedIds => questions.keys.toList()..sort();

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
  void calculateRotation() {
    if (totalQuestions == 0) return;

    _audioService.playSpinSound();

    final random = Random();
    winnerIndex = random.nextInt(totalQuestions);

    final sectorAngle = (2 * pi) / totalQuestions;
    final centerOfWinnerSlice =
        (winnerIndex! * sectorAngle) + (sectorAngle / 2);
    final targetRelative = -centerOfWinnerSlice;

    double fullSpins = (5 + random.nextInt(3)) * 2 * pi;
    double finalRotation =
        currentRotation +
        fullSpins +
        (targetRelative - (currentRotation % (2 * pi)));

    if (finalRotation <= currentRotation) {
      finalRotation += 2 * pi;
    }

    targetRotationAngle = finalRotation;
  }

  @action
  void updateRotation(double value) {
    currentRotation = value;
  }

  @action
  void completeRotation() {
    _audioService.playResultSound();
  }
}
