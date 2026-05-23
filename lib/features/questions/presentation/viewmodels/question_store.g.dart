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
  Computed<List<int>>? _$sortedIdsComputed;

  @override
  List<int> get sortedIds => (_$sortedIdsComputed ??= Computed<List<int>>(
    () => super.sortedIds,
    name: 'QuestionStoreBase.sortedIds',
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

  late final _$winnerIndexAtom = Atom(
    name: 'QuestionStoreBase.winnerIndex',
    context: context,
  );

  @override
  int? get winnerIndex {
    _$winnerIndexAtom.reportRead();
    return super.winnerIndex;
  }

  @override
  set winnerIndex(int? value) {
    _$winnerIndexAtom.reportWrite(value, super.winnerIndex, () {
      super.winnerIndex = value;
    });
  }

  late final _$targetRotationAngleAtom = Atom(
    name: 'QuestionStoreBase.targetRotationAngle',
    context: context,
  );

  @override
  double get targetRotationAngle {
    _$targetRotationAngleAtom.reportRead();
    return super.targetRotationAngle;
  }

  @override
  set targetRotationAngle(double value) {
    _$targetRotationAngleAtom.reportWrite(value, super.targetRotationAngle, () {
      super.targetRotationAngle = value;
    });
  }

  late final _$currentRotationAtom = Atom(
    name: 'QuestionStoreBase.currentRotation',
    context: context,
  );

  @override
  double get currentRotation {
    _$currentRotationAtom.reportRead();
    return super.currentRotation;
  }

  @override
  set currentRotation(double value) {
    _$currentRotationAtom.reportWrite(value, super.currentRotation, () {
      super.currentRotation = value;
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

  late final _$QuestionStoreBaseActionController = ActionController(
    name: 'QuestionStoreBase',
    context: context,
  );

  @override
  void calculateRotation() {
    final _$actionInfo = _$QuestionStoreBaseActionController.startAction(
      name: 'QuestionStoreBase.calculateRotation',
    );
    try {
      return super.calculateRotation();
    } finally {
      _$QuestionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateRotation(double value) {
    final _$actionInfo = _$QuestionStoreBaseActionController.startAction(
      name: 'QuestionStoreBase.updateRotation',
    );
    try {
      return super.updateRotation(value);
    } finally {
      _$QuestionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void completeRotation() {
    final _$actionInfo = _$QuestionStoreBaseActionController.startAction(
      name: 'QuestionStoreBase.completeRotation',
    );
    try {
      return super.completeRotation();
    } finally {
      _$QuestionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
questions: ${questions},
winnerIndex: ${winnerIndex},
targetRotationAngle: ${targetRotationAngle},
currentRotation: ${currentRotation},
totalQuestions: ${totalQuestions},
sortedIds: ${sortedIds}
    ''';
  }
}
