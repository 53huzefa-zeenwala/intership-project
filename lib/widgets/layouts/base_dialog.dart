import 'package:flutter/material.dart';
import 'package:main_project/widgets/custom_button/primary_button.dart';
import 'package:main_project/widgets/custom_button/secondary_button.dart';

class BaseDialog extends StatelessWidget {
  final double maxWidth;
  final Function() mainFunction;
  final String title;
  final Widget displayData;
  const BaseDialog(
      {super.key,
      required this.maxWidth,
      required this.mainFunction,
      required this.title, required this.displayData});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(50),
      child: Container(
        clipBehavior: Clip.hardEdge,
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).dialogBackgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).highlightColor,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displayLarge?.merge(
                          const TextStyle(
                            letterSpacing: 1.05,
                          ),
                        ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            displayData,
            Container(
              decoration: const BoxDecoration(
                  border: BorderDirectional(top: BorderSide(width: 1))),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  SecondaryButton(title: 'Close', onTap: () => Navigator.pop(context), fontSize: 16, paddingHorizontal: 22, paddingVertical: 16, ),
                  const SizedBox(width: 20),
                  PrimaryButton(title: 'Edit', onTap: mainFunction, fontSize: 16, paddingHorizontal: 26, paddingVertical: 18, ),
                  // FilledButton(
                  //   onPressed: mainFunction,
                  //   style: FilledButton.styleFrom(
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(4)),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 20, vertical: 15),
                  //     backgroundColor: Theme.of(context).primaryColor,
                  //   ),
                  //   child: const Text(
                  //     'Edit',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         letterSpacing: 1.1,
                  //         fontSize: 16),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
