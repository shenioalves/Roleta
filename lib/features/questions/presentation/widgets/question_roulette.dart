import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';

class QuestionRoulette extends StatefulWidget {
  final int count;
  final Function(int) onResult;

  const QuestionRoulette({
    super.key,
    required this.count,
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
    if (_controller.isAnimating || widget.count == 0) return;

    // 1. Sorteia o índice vencedor antes de começar a animação
    final int winnerIndex = _random.nextInt(widget.count);
    
    // 2. Cálculo matemático preciso para alinhar o número sorteado com o topo (12h)
    // O ponteiro fixo está em -pi/2.
    // Cada fatia i ocupa de (i * sectorAngle) até ((i+1) * sectorAngle).
    // O centro da fatia i está em (i + 0.5) * sectorAngle.
    // Queremos que o centro da fatia i pare exatamente no topo (-pi/2).
    // Rotação necessária = (-pi/2) - (centro da fatia i).
    
    double sectorAngle = (2 * pi) / widget.count;
    double centerOfWinnerSlice = (winnerIndex * sectorAngle) + (sectorAngle / 2);
    
    // Rotação alvo relativa para colocar o índice no topo
    double targetRotationRelative = - (pi / 2) - centerOfWinnerSlice;
    
    // Adicionamos voltas completas (mínimo 5 voltas) para o efeito visual
    double fullSpins = (5 + _random.nextInt(3)) * 2 * pi;
    double finalRotation = _currentRotation + fullSpins + (targetRotationRelative - (_currentRotation % (2 * pi)));
    
    // Garante que o giro seja sempre para frente
    if (finalRotation <= _currentRotation) {
      finalRotation += 2 * pi;
    }

    _animation = Tween<double>(
      begin: _currentRotation,
      end: finalRotation,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    ));

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
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Aumento expressivo de tamanho (dominando a tela)
              final size = min(constraints.maxWidth, constraints.maxHeight) * 0.95;
              
              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // ROLETA UNIFICADA: Imagem + Números + Fatias giram juntos
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animation.value,
                          child: child,
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Disco de Fatias
                          SizedBox(
                            width: size,
                            height: size,
                            child: CustomPaint(
                              painter: RoulettePainter(
                                count: widget.count,
                                color1: AppColors.primary,
                                color2: AppColors.secondary,
                              ),
                            ),
                          ),
                          // Números
                          ...List.generate(widget.count, (index) {
                            final sectorAngle = (2 * pi) / widget.count;
                            final angle = index * sectorAngle;
                            
                            return Transform.rotate(
                              angle: angle,
                              child: Container(
                                height: size,
                                width: size,
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(top: size * 0.08),
                                  child: Transform.rotate(
                                    angle: sectorAngle / 2, // Centraliza o número na fatia
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
                              ),
                            );
                          }),
                          // LOGO TITAN CENTRAL (Aumentada e girando junto)
                          Container(
                            width: size * 0.55, // Aumentada
                            height: size * 0.55,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SvgPicture.asset(
                                'assets/logo.svg',
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    // PONTEIRO FIXO (No topo, posição 12h)
                    Positioned(
                      top: (constraints.maxHeight - size) / 2 - 20,
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10)
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 80,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: widget.count > 0 ? spin : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 25),
            elevation: 10,
            side: const BorderSide(color: AppColors.primary, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: const Text(
            'GIRAR ROLETA',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 50),
      ],
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
        (i * sectorAngle) - (pi / 2), // Começa do topo
        sectorAngle,
        true,
        paint,
      );
    }
    
    // Linhas divisórias para melhor visualização
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

    // Borda externa premium
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
