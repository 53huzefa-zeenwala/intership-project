import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool expand;
  final double fontSize;
  final double paddingVertical;
  final double paddingHorizontal;

  const PrimaryButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.expand = false,
      this.fontSize = 24,
      this.paddingVertical = 15,
      this.paddingHorizontal = 30});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: expand ? Size(double.infinity, paddingVertical * 2) : null,
        elevation: 2,
        padding: EdgeInsets.symmetric(
            vertical: paddingVertical, horizontal: paddingHorizontal),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onTertiary,
            letterSpacing: 1.1),
      ),
    );
  }
}
