// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuestionStore on QuestionStoreBase, Store {
  Computed<int>? _$totalQuestionsComputed;

  @override
  int get totalQuestions => (_$totalQuestionsComputed ??= Computed<int>(
    () => super.totalQuestions,
    name: 'QuestionStoreBase.totalQuestions',
  )).value;

  late final _$questionsAtom = Atom(
    name: 'QuestionStoreBase.questions',
    context: context,
  );

  @override
  ObservableMap<int, String> get questions {
    _$questionsAtom.reportRead();
    return super.questions;
  }

  @override
  set questions(ObservableMap<int, String> value) {
    _$questionsAtom.reportWrite(value, super.questions, () {
      super.questions = value;
    });
  }

  late final _$_loadQuestionsAsyncAction = AsyncAction(
    'QuestionStoreBase._loadQuestions',
    context: context,
  );

  @override
  Future<void> _loadQuestions() {
    return _$_loadQuestionsAsyncAction.run(() => super._loadQuestions());
  }

  late final _$addQuestionAsyncAction = AsyncAction(
    'QuestionStoreBase.addQuestion',
    context: context,
  );

  @override
  Future<void> addQuestion(String text) {
    return _$addQuestionAsyncAction.run(() => super.addQuestion(text));
  }

  late final _$deleteQuestionAsyncAction = AsyncAction(
    'QuestionStoreBase.deleteQuestion',
    context: context,
  );

  @override
  Future<void> deleteQuestion(int id) {
    return _$deleteQuestionAsyncAction.run(() => super.deleteQuestion(id));
  }

  @override
  String toString() {
    return '''
questions: ${questions},
totalQuestions: ${totalQuestions}
    ''';
  }
}
