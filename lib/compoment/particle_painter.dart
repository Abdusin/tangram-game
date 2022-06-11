import 'package:flutter/material.dart';

class ParticlePainter extends CustomPainter {
  final List<Offset> offsets;
  final bool isRandomColor;
  final Color particleColor;
  final Paint constColorPaint;
  final double maxParticleSize;
  static Color randomColor = Colors.blue;
  static Paint? randomColorPaint;
  final List<double> randSize;
  final bool isRandSize;
  final List<Color> randColorList;

  ParticlePainter({
    required this.randColorList,
    required this.isRandSize,
    required this.maxParticleSize,
    required this.offsets,
    required this.isRandomColor,
    required this.particleColor,
    required this.randSize,
  }) : constColorPaint = Paint()..color = particleColor;

  @override
  void paint(Canvas canvas, Size size) {
    for (int index = 0; index < offsets.length; index++) {
      if (isRandomColor) {
        randomColor = randColorList[index % randColorList.length];

        randomColorPaint = Paint()..color = randomColor;
        canvas.drawRect(
          Rect.fromCircle(
            center: offsets[index],
            radius: isRandSize ? maxParticleSize * (randSize[index]) : maxParticleSize,
          ),
          randomColorPaint!,
        );
      } else {
        randomColorPaint = Paint()..color = randomColor;
        var size = isRandSize ? maxParticleSize * (randSize[index]) : maxParticleSize;
        canvas.drawRect(
          Rect.fromCenter(
            center: offsets[index],
            width: size,
            height: size,
          ),
          constColorPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
