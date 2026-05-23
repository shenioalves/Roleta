import 'package:hive_ce_flutter/hive_flutter.dart';
import '../models/question_model.dart';

abstract class QuestionRepository {
  Future<void> init();
  List<QuestionModel> getQuestions();
  Future<void> addQuestion(String text);
  Future<void> deleteQuestion(int id);
  Future<void> clearAll();
}

class QuestionRepositoryImpl implements QuestionRepository {
  static const String _boxName = 'questions_box';
  late Box<QuestionModel> _box;

  @override
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(QuestionModelAdapter());
    }
    _box = await Hive.openBox<QuestionModel>(_boxName);
  }

  @override
  List<QuestionModel> getQuestions() {
    return _box.values.toList();
  }

  @override
  Future<void> addQuestion(String text) async {
    final id = _box.isEmpty ? 1 : (_box.values.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1);
    final question = QuestionModel(id: id, text: text);
    await _box.add(question);
  }

  @override
  Future<void> deleteQuestion(int id) async {
    final key = _box.keys.firstWhere((k) => _box.get(k)?.id == id);
    await _box.delete(key);
  }

  @override
  Future<void> clearAll() async {
    await _box.clear();
  }
}
