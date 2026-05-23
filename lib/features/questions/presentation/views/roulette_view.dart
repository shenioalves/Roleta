import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/theme/app_colors.dart';
import '../viewmodels/question_store.dart';
import '../widgets/question_roulette.dart';

class RouletteView extends StatelessWidget {
  final QuestionStore store;

  const RouletteView({super.key, required this.store});

  void _showQuestionDialog(BuildContext context, int index) {
    final sortedIds = store.questions.keys.toList()..sort();
    final questionId = sortedIds[index];
    final questionText =
        store.questions[questionId] ?? 'Pergunta não encontrada';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pergunta ${index + 1}',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.primary),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        content: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 18.0,
              ),
              child: Text(questionText, style: const TextStyle(fontSize: 18)),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/tito_pensador.jpeg',

                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return store.totalQuestions == 0
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.help_outline, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Nenhuma pergunta cadastrada.\nVá para a aba Admin.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : QuestionRoulette(
                store: store,
                onResult: (index) => _showQuestionDialog(context, index),
              );
      },
    );
  }
}
