import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../../core/colors/app_colors.dart';

class ArcChart extends StatefulWidget {
  final String label;
  final double value;

  const ArcChart({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  State<ArcChart> createState() => _ArcChartState();
}

class _ArcChartState extends State<ArcChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animateArc();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> animateArc() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.animateTo(widget.value, duration: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return Column(
        children: [
          CustomPaint(
            willChange: true,
            size: Size(size.width * 0.75, size.height * 0.30),
            painter: _ArcPainter(
              value: widget.value,
              label: widget.label,
              listenable: _controller,
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  '0',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 25),
                child: Text(
                  '100',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class _ArcPainter extends CustomPainter {
  final double value;
  final String label;
  final Animation listenable;

  _ArcPainter(
    {
    required this.value,
    required this.label,
    required this.listenable,
  }) : super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    Rect drawingRect = Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: size.width / 2);

    final Paint grey = Paint();
    grey.color = const Color(AppColors.grey).withAlpha(100);
    grey.style = PaintingStyle.stroke;
    grey.strokeWidth = 80;

    final Paint valuePaint = Paint();
    late final Color valueColor;
    final value = listenable.value;
    switch (value) {
      case < 0.25:
        valueColor = const Color(AppColors.green);
        break;
      case >= 0.25 && < 0.50:
        valueColor = const Color(AppColors.yellow);
        break;
      case >= 0.50 && < 0.75:
        valueColor = const Color(AppColors.orange);
        break;
      case >= 0.75:
        valueColor = const Color(AppColors.red);
        break;
      default:
        valueColor = const Color(AppColors.grey).withAlpha(100);
    }

    valuePaint.color = valueColor;
    valuePaint.style = PaintingStyle.stroke;
    valuePaint.strokeWidth = 80;

    canvas.drawArc(
      drawingRect,
      pi,
      pi,
      false,
      grey,
    );

    canvas.drawArc(
      drawingRect,
      pi * -(1 - value),
      pi * -(value),
      false,
      valuePaint,
    );

    final valueText = TextPainter(
      text: TextSpan(
        text: '${(value * 100).toStringAsFixed(2)} %',
        style: TextStyle(
          color: valueColor,
          fontSize: 30.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    valueText.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    valueText.paint(
      canvas,
      Offset(
        (size.width - valueText.width) / 2,
        (size.height - valueText.height),
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// class ArcChart extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Rect drawingRect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2);

//     final Paint grey = Paint();
//     grey.color = const Color.fromRGBO(0, 0, 0, 0.04);
//     grey.style = PaintingStyle.stroke;
//     grey.strokeWidth = 50;

//     final Paint orange = Paint();
//     orange.color = Colors.orange;

//     final Paint green = Paint();
//     green.color = Colors.green;

//     canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, grey);

//     canvas.drawArc(
//       drawingRect,
//       -pi / 2 + 0.35,
//       pi - 0.35,
//       false,
//       green,
//     );

//     canvas.drawArc(
//       drawingRect,
//       pi / 2 + 0.35,
//       pi - 0.35,
//       false,
//       orange,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
