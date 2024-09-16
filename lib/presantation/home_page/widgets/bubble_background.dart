import 'dart:math';

import 'package:flutter/material.dart';

import 'bubble_painter.dart';

class AnimatedBubbleBackground extends StatefulWidget {
  final Size size;
  const AnimatedBubbleBackground({super.key, required this.size});@override
  State<AnimatedBubbleBackground> createState() => _AnimatedBubbleBackgroundState();
}

class _AnimatedBubbleBackgroundState extends State<AnimatedBubbleBackground>
    with SingleTickerProviderStateMixin { // Mixin for efficient animation handling.

  late AnimationController _controller;late List<Bubble> _bubbles;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _bubbles = _generateBubbles(50);
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this, // Use mixin for vsync.
    )..addListener(_updateBubbles)
      ..repeat();
  }

  // Improvement: Extract bubble generation logic for better organization.
  List<Bubble> _generateBubbles(int count) {
    final screenWidth = widget.size.width;
    final screenHeight = widget.size.height;

    return List.generate(count, (index) {
      return Bubble(
        _random.nextDouble() * screenWidth,
        _random.nextDouble() * screenHeight,
        _random.nextDouble() * 20 + 10, // Adjust range for bubble size as needed.
        (_random.nextDouble() - 0.5) * 4, // Improve speed distribution.
        (_random.nextDouble() - 0.5) * 4,
        Color.fromRGBO(
          _random.nextInt(256),
          _random.nextInt(256),
          _random.nextInt(256),
          0.5,
        ),
      );
    });
  }

  void _updateBubbles() {
    final screenWidth = widget.size.width;
    final screenHeight = widget.size.height;

    for (var bubble in _bubbles) {
      bubble.x += bubble.dx;
      bubble.y += bubble.dy;

      // Improvement: Simplify boundary checks.
      if (bubble.x < 0 || bubble.x > screenWidth) {
        bubble.dx = -bubble.dx;
      }
      if (bubble.y < 0 || bubble.y > screenHeight) {
        bubble.dy = -bubble.dy;
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BubblePainter(_bubbles),
        size: widget.size, // Optimization: Provide size to CustomPaint.
        child: Container(), // Consider replacing with a more meaningful child if needed.
      ),
    );
  }
}