import 'package:animated_indexed_stack/fade_through_indexed_stack.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  int _currentIndex = 0;

  final _pages = const [
    _ColorList(
      key: ValueKey("1"),
      color: Colors.blue,
    ),
    _ColorList(
      key: ValueKey("2"),
      color: Colors.red,
    ),
    _ColorList(
      key: ValueKey("3"),
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeThroughIndexedStack(
        index: _currentIndex,
        children: const [
          _ColorList(color: Colors.blue),
          _ColorList(color: Colors.red),
          _ColorList(color: Colors.green),
        ],
      ),
      // body: PageTransitionSwitcher(
      //   transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
      //     return FadeThroughTransition(
      //       animation: primaryAnimation,
      //       secondaryAnimation: secondaryAnimation,
      //       child: child,
      //     );
      //   },
      //   child: _pages[_currentIndex],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class _ColorList extends StatelessWidget {
  const _ColorList({super.key, required this.color});

  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        final itemColor = color[(index % 9 + 1) * 100];

        return Container(
          color: itemColor,
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text("$index ${itemColor.toString()}"),
          ),
        );
      },
    );
  }
}
