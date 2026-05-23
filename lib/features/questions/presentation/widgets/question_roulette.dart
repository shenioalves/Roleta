import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/roulette_constants.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: RouletteConstants.rotationDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    );
  }

  void spin() {
    if (_controller.isAnimating || widget.store.totalQuestions == 0) return;

    widget.store.spin();

    _animation = Tween<double>(
      begin: widget.store.currentRotation,
      end: widget.store.targetRotationAngle,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    _controller.forward(from: 0).then((_) {
      widget.store.updateRotation(widget.store.targetRotationAngle);
      widget.store.completeRotation();
      if (widget.store.winnerIndex != null) {
        widget.onResult(widget.store.winnerIndex!);
      }
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
        final double scaleW = constraints.maxWidth / 1440;
        final double scaleH = constraints.maxHeight / 783;
        final double scale = min(scaleW, scaleH);

        final size = min(constraints.maxWidth, constraints.maxHeight) * 0.75;

        return Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
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
                                  child: Padding(
                                    padding: EdgeInsets.only(top: size * 0.02),
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
                              placeholderBuilder: (context) => Center(
                                child: Text(
                                  'TITAN',
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontSize: size * 0.1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -size * 0.09,
                        child: Icon(
                          Icons.arrow_drop_down_sharp,
                          size: size * 0.2,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 60 * scale,
                        vertical: 25 * scale,
                      ),
                      elevation: 10,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40 * scale),
                      ),
                    ),
                    child: Text(
                      'GIRAR ROLETA',
                      style: TextStyle(
                        fontSize: 24 * scale,
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
                height: size * 0.8,
              ),
            ),
            Positioned(
              right: -size * 0.19,
              bottom: -size * 0.13,
              child: Image.asset(
                'assets/tito_beats_bg.png',
                alignment: Alignment.bottomRight,
                fit: BoxFit.contain,
                height: size * 0.9,
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
