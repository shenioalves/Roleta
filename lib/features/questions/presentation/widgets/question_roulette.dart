import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../viewmodels/question_store.dart';

class QuestionRoulette extends StatefulWidget {
  final QuestionStore store;
  final Function(int) onResult;

  const QuestionRoulette({
    super.key,
    required this.store,
    required this.onResult,
  });

  @override
  State<QuestionRoulette> createState() => _QuestionRouletteState();
}

class _QuestionRouletteState extends State<QuestionRoulette>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentRotation = 0;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    );
  }

  void spin() {
    if (_controller.isAnimating || widget.store.totalQuestions == 0) return;

    widget.store.drawWinner();

    final int winnerIndex = widget.store.winnerIndex!;
    final double targetRotationRelative = widget.store.targetRotationAngle;

    double fullSpins = (5 + _random.nextInt(3)) * 2 * pi;
    double finalRotation =
        _currentRotation +
        fullSpins +
        (targetRotationRelative - (_currentRotation % (2 * pi)));

    if (finalRotation <= _currentRotation) {
      finalRotation += 2 * pi;
    }

    _animation = Tween<double>(
      begin: _currentRotation,
      end: finalRotation,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    _currentRotation = finalRotation;

    _controller.forward(from: 0).then((_) {
      widget.onResult(winnerIndex);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight) * 0.7;

        return Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _animation.value,
                            child: child,
                          );
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: size,
                              height: size,
                              child: CustomPaint(
                                painter: RoulettePainter(
                                  count: widget.store.totalQuestions,
                                  color1: AppColors.primary,
                                  color2: AppColors.secondary,
                                ),
                              ),
                            ),
                            ...List.generate(widget.store.totalQuestions, (
                              index,
                            ) {
                              final sectorAngle =
                                  (2 * pi) / widget.store.totalQuestions;
                              final angle =
                                  index * sectorAngle + sectorAngle / 2;

                              return Transform.rotate(
                                angle: angle,
                                child: Container(
                                  height: size,
                                  width: size,
                                  alignment: Alignment.topCenter,
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                  ),
                                ),
                              );
                            }),
                            ...List.generate(widget.store.totalQuestions, (
                              index,
                            ) {
                              final sectorAngle =
                                  (2 * pi) / widget.store.totalQuestions;
                              final angle =
                                  index * sectorAngle + sectorAngle / 2;

                              return Transform.rotate(
                                angle: angle,
                                child: Container(
                                  height: size,
                                  width: size,
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: size * 0.06,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: const [
                                          Shadow(
                                            blurRadius: 4.0,
                                            color: Colors.black54,
                                            offset: Offset(2.0, 2.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                            SvgPicture.asset(
                              'assets/logo.svg',
                              width: size * 0.8,
                              height: size * 0.8,
                              placeholderBuilder: (context) => const Center(
                                child: Text(
                                  'TITAN',
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: (constraints.maxHeight - size) / 2 - 135,
                        child: Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 80,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: widget.store.totalQuestions > 0 ? spin : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 25,
                      ),
                      elevation: 10,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Text(
                      'GIRAR ROLETA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                'assets/tito_ansioso.png',
                alignment: Alignment.bottomLeft,
                fit: BoxFit.contain,
                height: size * 1.1,
              ),
            ),
            Positioned(
              right: -110,
              bottom: -70,
              child: Image.asset(
                'assets/tito_beats_bg.png',
                alignment: Alignment.bottomRight,
                fit: BoxFit.contain,
                height: size * 1.2,
              ),
            ),
          ],
        );
      },
    );
  }
}

class RoulettePainter extends CustomPainter {
  final int count;
  final Color color1;
  final Color color2;

  RoulettePainter({
    required this.count,
    required this.color1,
    required this.color2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (count == 0) return;

    final paint = Paint()..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sectorAngle = (2 * pi) / count;

    for (int i = 0; i < count; i++) {
      paint.color = i % 2 == 0 ? color1 : color2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        (i * sectorAngle) - (pi / 2),
        sectorAngle,
        true,
        paint,
      );
    }

    paint.color = Colors.white24;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    for (int i = 0; i < count; i++) {
      final angle = (i * sectorAngle) - (pi / 2);
      canvas.drawLine(
        center,
        center + Offset(cos(angle) * radius, sin(angle) * radius),
        paint,
      );
    }

    paint.color = AppColors.secondary;
    paint.strokeWidth = 8;
    canvas.drawCircle(center, radius, paint);

    paint.color = AppColors.primary;
    paint.strokeWidth = 2;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
