import 'package:flutter/material.dart';
import 'dart:math';

class FlipCardController {
  FlipCardWidgetState? _state;

  Future flipCard() async => _state?.flipCard();
}

class FlipCardWidget extends StatefulWidget {
  final Widget front;
  final Widget back;
  final FlipCardController controller;

  FlipCardWidget(
      {Key? key,
      required this.front,
      required this.back,
      required this.controller})
      : super(key: key);

  @override
  State<FlipCardWidget> createState() => FlipCardWidgetState();
}

class FlipCardWidgetState extends State<FlipCardWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isFront = true;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    widget.controller._state = this;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future flipCard() async {
    if (!isFront) {
      await controller.reverse();
    } else {
      await controller.forward();
    }
    isFront = !isFront;
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final angle = controller.value * -pi;
        final transform = Matrix4.identity()..rotateY(angle);

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: isFrontImage(angle.abs())
              ? widget.front
              : Transform(
                  transform: Matrix4.identity()..rotateY(pi),
                  alignment: Alignment.center,
                  child: widget.back,
                ),
        );
      });

  bool isFrontImage(double angle) {
    const degrees90 = pi / 2;
    const degrees270 = 3 * pi / 2;

    return angle <= degrees90 || angle >= degrees270;
  }
}
