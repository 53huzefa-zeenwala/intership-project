import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  final Widget child;

  const InputContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsetsDirectional.symmetric(
              vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              border: BorderDirectional(
                  bottom: BorderSide(width: 2, color: Colors.grey.shade300))),
          child: child),
    );
  }
}

class InputFrame extends StatelessWidget {
  final String remark;
  final String title;
  final Widget inputField;

  const InputFrame({
    super.key,
    this.remark = '',
    required this.title,
    required this.inputField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: remark == ''
              ? const EdgeInsetsDirectional.symmetric(vertical: 2)
              : const EdgeInsetsDirectional.only(top: 2, bottom: 10),
          child: Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(
                    maxLines: 2,
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // const SizedBox(width: 20),
                Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft, child: inputField),
                )
              ]),
        ),
        Text(remark,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
      ],
    );
  }
}

class MultipleInputFrame extends StatelessWidget {
  final String remark;
  final String title;
  final Widget smallerInputField;
  final Widget largerInputField;

  const MultipleInputFrame({
    super.key,
    this.remark = '',
    required this.title,
    required this.smallerInputField,
    required this.largerInputField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 50,
          constraints: const BoxConstraints(maxWidth: 800),
          padding: remark == ''
              ? const EdgeInsetsDirectional.symmetric(vertical: 0)
              : const EdgeInsetsDirectional.only(top: 2, bottom: 10),
          child: Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(
                    maxLines: 2,
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 120, child: smallerInputField),
                const SizedBox(width: 10),
                Expanded(child: largerInputField)
              ]),
        ),
        Text(
          remark,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
