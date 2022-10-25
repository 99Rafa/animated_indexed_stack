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
    with TickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 250);
  late final AnimationController controller;
  late final AnimationController secondaryController;
  late final Animation<double> animation;
  late final Animation<double> secondaryAnimation;

  int _currentIndex = 0;

  Future<void> transition() async {
    controller.value = 1;
    secondaryController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 50));
    setState(() {
      _currentIndex = widget.index;
    });

    secondaryController.value = 0;
    controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(FadeThroughIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      transition();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: _duration);
    secondaryController = AnimationController(vsync: this, duration: _duration);
    controller.value = 1;

    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);
    secondaryAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(secondaryController);
  }

  @override
  void dispose() {
    controller.dispose();
    secondaryController.dispose();
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
