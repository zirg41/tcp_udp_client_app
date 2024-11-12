import "package:flutter/material.dart";

class MessageTextField extends StatelessWidget {
  final TextEditingController messageController;
  final VoidCallback onSend;

  const MessageTextField({
    required this.messageController,
    required this.onSend,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageController,
            decoration: const InputDecoration(
              labelText: "Message",
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onEditingComplete: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filled(
          onPressed: onSend,
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
