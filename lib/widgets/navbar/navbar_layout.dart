import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final Widget child;

  const Navbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        
      ),
      child: child,
    );
  }
}
