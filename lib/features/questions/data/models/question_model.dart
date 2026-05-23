import 'package:hive_ce/hive.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String text;

  QuestionModel({required this.id, required this.text});
}
