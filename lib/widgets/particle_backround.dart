library particles_flutter;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gamepanel/compoment/particle_painter.dart';
import 'package:get/get.dart';

class CircularParticle extends StatefulWidget {
  const CircularParticle({
    Key? key,
    required this.height,
    required this.width,
    this.onTapAnimation = true,
    this.numberOfParticles = 500,
    this.speedOfParticles = 2,
    this.awayRadius = 100,
    required this.isRandomColor,
    this.particleColor = Colors.white,
    this.awayAnimationDuration = const Duration(milliseconds: 600),
    this.maxParticleSize = 4,
    this.isRandSize = false,
    this.randColorList = const [
      Colors.black,
      Colors.blue,
      Colors.white,
      Colors.red,
      Colors.green,
    ],
    this.awayAnimationCurve = Curves.easeIn,
    this.enableHover = false,
    this.hoverColor = Colors.orangeAccent,
    this.hoverRadius = 80,
    this.connectDots = false,
  }) : super(key: key);
  final double awayRadius;
  final double height;
  final double width;
  final bool onTapAnimation;
  final double numberOfParticles;
  final double speedOfParticles;
  final bool isRandomColor;
  final Color particleColor;
  final Duration awayAnimationDuration;
  final Curve awayAnimationCurve;
  final double maxParticleSize;
  final bool isRandSize;
  final List<Color> randColorList;
  final bool enableHover;
  final Color hoverColor;
  final double hoverRadius;
  final bool connectDots; //not recommended

  @override
  _CircularParticleState createState() => _CircularParticleState();
}

class _CircularParticleState extends State<CircularParticle> with TickerProviderStateMixin {
  late Animation<int> animation;
  late AnimationController controller;
  late AnimationController awayAnimationController;
  late double dx;
  late double dy;
  late var particles = List.generate(widget.numberOfParticles.toInt(), (index) => Particle());
  var allOffsets = <List<Offset>>[];
  double speedOfparticle = 0;
  var rng = Random();
  double randValue = 0;
  _CircularParticleState();
  List<double> randomSize = [];

  void initailizeOffsets(_) {
    for (int index = 0; index < widget.numberOfParticles; index++) {
      randomSize.add(rng.nextDouble());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(initailizeOffsets);
    controller = AnimationController(duration: const Duration(seconds: 7), vsync: this);
    animation = StepTween(begin: 0, end: 120).animate(controller);
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        for (var i = 0; i < particles.length; i++) {
          particles[i].setOffset();
        }
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        for (var i = 0; i < particles.length; i++) {
          particles[i].setSpeeds();
        }
        controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) => CustomPaint(
          painter: ParticlePainter(
            offsets: particles.map((e) => e.getOffset(animation.value)).toList(),
            isRandomColor: widget.isRandomColor,
            particleColor: widget.particleColor,
            maxParticleSize: widget.maxParticleSize,
            randSize: randomSize,
            isRandSize: widget.isRandSize,
            randColorList: widget.randColorList.map((e) => e.withOpacity(1 - (animation.value / 120))).toList(),
          ),
        ),
      ),
    );
  }
}

class Particle {
  late Offset offset;
  late double xSpeed;
  late double ySpeed;
  Particle() {
    setOffset();
    setSpeeds();
  }

  void setOffset() {
    offset = Offset(Random().nextDouble() * Get.width, Random().nextDouble() * Get.height);
  }

  void setSpeeds() {
    xSpeed = Random().nextDouble() * (Random().nextBool() ? 1.0 : -1.0);
    ySpeed = Random().nextDouble() * (Random().nextBool() ? 1.0 : -1.0);
  }

  Offset getOffset(int index) {
    return offset + Offset(xSpeed * index, ySpeed * index);
  }
}

class ParticleBackground extends StatelessWidget {
  const ParticleBackground({
    Key? key,
    required this.child,
    this.opacity = 0.4,
  }) : super(key: key);
  final Widget child;
  final double opacity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: CircularParticle(
            awayRadius: 80,
            numberOfParticles: 80,
            speedOfParticles: 1,
            height: Get.height,
            width: Get.width,
            onTapAnimation: false,
            particleColor: Colors.red.withAlpha(150),
            awayAnimationDuration: const Duration(milliseconds: 600),
            maxParticleSize: 6,
            isRandSize: false,
            isRandomColor: true,
            randColorList: [
              Colors.red.withOpacity(0.7),
              Colors.yellow.withOpacity(0.7),
              Colors.green.withOpacity(0.7),
              Colors.blue.withOpacity(0.7),
            ],
            awayAnimationCurve: Curves.ease,
            enableHover: false,
            hoverColor: Colors.amberAccent,
            hoverRadius: 90,
            connectDots: false,
          ),
        ),
        Container(
          width: Get.width,
          height: Get.height,
          color: Get.theme.colorScheme.background.withOpacity(opacity),
        ),
        child,
      ]),
    );
  }
}
