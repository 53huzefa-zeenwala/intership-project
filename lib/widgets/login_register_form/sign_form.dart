import 'package:flutter/material.dart';

class SignPage extends StatelessWidget {
  final Widget child;
  const SignPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 360,
        // height: 700,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
        constraints: const BoxConstraints(maxHeight: 380),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Theme.of(context).colorScheme.onTertiary,
            boxShadow: [
              BoxShadow(
                  color: const Color(0x00000000).withOpacity(1),
                  offset: const Offset(8, 8),
                  blurRadius: 10,
                  spreadRadius: -8)
            ]),
        child: child,
      ),
    );
  }
}
