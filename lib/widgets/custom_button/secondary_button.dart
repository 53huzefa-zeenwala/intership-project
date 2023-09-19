import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool expand;
  final double fontSize;
  final double paddingVertical;
  final double paddingHorizontal;

  const SecondaryButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.expand = false,
      this.fontSize = 24,
      this.paddingVertical = 15,
      this.paddingHorizontal = 30});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
          // strokeAlign: BorderSide.strokeAlignCenter,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: expand ? Size(double.infinity, paddingVertical * 2) : null,
        padding: EdgeInsets.symmetric(
            vertical: paddingVertical, horizontal: paddingHorizontal),
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor),
      ),
    );
  }
}
