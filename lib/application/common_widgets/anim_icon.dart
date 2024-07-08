import 'package:flutter/material.dart';

class AnimatedCrown extends StatefulWidget {
  const AnimatedCrown({super.key});

  @override
  State<AnimatedCrown> createState()=> _AnimatedCrownState();
}

class _AnimatedCrownState extends State<AnimatedCrown>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);

  // Limit going up by setting the 'begin' value to -20
  late final Animation<double> _animation = Tween<double>(
    begin: -20, // Upper limit for the animation
    end: 50,
  ).animate(_controller);
  @override
  void initState() {
    super.initState();
   // _controller.forward(); // Start the animation when the widget is initialized

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 18 * _controller.value),
          child: child,
        );
      },
      child: const Icon(Icons.question_mark_sharp, size: 40,)
    );
  }
}