import "package:flutter/material.dart";
import "package:tcp_udp_client_app/features/tcp_client/domain/message.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/message_item.dart";

class MessagesListView extends StatelessWidget {
  final List<Message> messages;
  final VoidCallback onClear;

  const MessagesListView({
    required this.messages,
    required this.onClear,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(border: Border.all()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                reverse: true,
                itemBuilder: (_, i) => MessageItem(messages[i]),
                itemCount: messages.length,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: onClear,
          child: const Text("Clear"),
        ),
      ],
    );
  }
}
