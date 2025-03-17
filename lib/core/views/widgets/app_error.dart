import 'package:flutter/material.dart';
import 'package:meal_plan/core/const/const.dart';

class AppError extends StatelessWidget {
  const AppError({super.key, required this.message, this.onTap});

  final void Function()? onTap;

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: context.color.error,
            size: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onTap != null
              ? IconButton(
                  onPressed: onTap,
                  icon: Icon(Icons.refresh),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
