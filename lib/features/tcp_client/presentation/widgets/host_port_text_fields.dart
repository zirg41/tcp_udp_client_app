import "package:flutter/material.dart";

class HostPortTextFields extends StatelessWidget {
  const HostPortTextFields({
    required this.hostController,
    required this.onEditingHostComplete,
    required this.portController,
    required this.onEditingPortComplete,
    super.key,
  });

  final TextEditingController hostController;
  final Null Function() onEditingHostComplete;
  final TextEditingController portController;
  final Null Function() onEditingPortComplete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: TextField(
            controller: hostController,
            decoration: const InputDecoration(
              labelText: "HOST",
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onEditingComplete: () {
              onEditingHostComplete();
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: TextField(
            controller: portController,
            decoration: const InputDecoration(
              labelText: "PORT",
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onEditingComplete: () {
              onEditingPortComplete();
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
      ],
    );
  }
}
