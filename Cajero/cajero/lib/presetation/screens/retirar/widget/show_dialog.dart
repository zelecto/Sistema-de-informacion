import 'package:cajero/config/tools/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showDialogView(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: ScreenSize.getHeight(context) * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/error.png',
                height: ScreenSize.getHeight(context) * 0.1,
                width: ScreenSize.getWidth(context) * 0.5,
                fit: BoxFit.cover,
              ),
              Text(message,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
