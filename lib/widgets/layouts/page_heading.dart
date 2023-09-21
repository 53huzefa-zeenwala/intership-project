import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  final String title;
  final Widget button;

  const PageHeading(
      {super.key, required this.title, this.button = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration:
          const BoxDecoration(border: BorderDirectional(bottom: BorderSide())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
          ),
          button
        ],
      ),
    );
  }
}
