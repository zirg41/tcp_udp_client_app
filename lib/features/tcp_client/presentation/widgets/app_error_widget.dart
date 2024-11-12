import "package:flutter/material.dart";

class AppErrorWidget extends StatelessWidget {
  final String error;
  const AppErrorWidget(
    this.error, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ColoredBox(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            error,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
