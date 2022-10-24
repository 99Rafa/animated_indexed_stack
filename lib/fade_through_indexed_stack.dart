import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';

class FadeThroughIndexedStack extends StatefulWidget {
  const FadeThroughIndexedStack({
    super.key,
    required this.index,
    required this.children,
  });

  final int index;
  final List<Widget> children;

  @override
  State<FadeThroughIndexedStack> createState() =>
      _FadeThroughIndexedStackState();
}

class _FadeThroughIndexedStackState extends State<FadeThroughIndexedStack>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 150);
  late final AnimationController controller;
  late final Animation<double> animation;
  late final Animation<double> secondaryAnimation;

  int _currentIndex = 0;

  @override
  void didUpdateWidget(FadeThroughIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.forward().then((_) {
      setState(() {
        _currentIndex = widget.index;
      });
      controller.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: _duration);

    animation = Tween(begin: 1.0, end: 0.0).animate(controller);
    secondaryAnimation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeThroughTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: IndexedStack(
        index: _currentIndex,
        children: widget.children,
      ),
    );
  }
}
