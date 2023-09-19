import 'package:flutter/material.dart';

enum AlertType { success, error, info }


class AlertSnackBar extends StatelessWidget {
  final AlertType type;
  final String message;
  const AlertSnackBar({
    super.key,
    required this.type,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      height: 75,
      decoration: BoxDecoration(
        color: type == AlertType.success
            ? const Color(0xFF15CD72)
            : type == AlertType.info
                ? const Color(0xFF4BB1CF)
                : const Color(0xFFED4F32),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Icon(
            type == AlertType.success
                ? Icons.check_circle
                : type == AlertType.info
                    ? Icons.message
                    : Icons.info_outline,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  type == AlertType.success
                      ? 'Success'
                      : type == AlertType.info
                          ? 'Info. Information'
                          : 'Oops. An Error Occurred',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                // Spacer(),
                Text(
                  message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: AlertSnackBar(
//                                   message:
//                                       'Something went wrong, try to refresh page or come back later.',
//                                   type: AlertType.success,
//                                 ),
//                                 behavior: SnackBarBehavior.floating,
//                                 backgroundColor: Colors.transparent,
//                                 elevation: 0,
//                                 width: 360,
//                               ),
//                             );