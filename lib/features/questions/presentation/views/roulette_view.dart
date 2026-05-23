import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodels/question_store.dart';
import '../widgets/question_roulette.dart';

class RouletteView extends StatelessWidget {
  const RouletteView({super.key});

  void _showQuestionDialog(
    BuildContext context,
    QuestionStore store,
    int index,
  ) {
    final questionId = store.sortedIds[index];
    final questionText =
        store.questions[questionId] ?? 'Pergunta não encontrada';
    showDialog(
      context: context,
      builder: (context) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final isMobile = screenWidth < 600;

        return AlertDialog(
          backgroundColor: AppColors.background,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pergunta ${index + 1}',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 24 : 30,
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
          content: SingleChildScrollView(
            child: isMobile
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          questionText,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Image.asset(
                        'assets/tito_pensador.png',
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ],
                  )
                : Wrap(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth * 0.3,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 18.0,
                          ),
                          child: Text(
                            questionText,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/tito_pensador.png',
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = locator<QuestionStore>();

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
                onResult: (index) => _showQuestionDialog(context, store, index),
              );
      },
    );
  }
}
