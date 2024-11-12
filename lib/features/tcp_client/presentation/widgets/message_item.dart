import "package:flutter/material.dart";
import "package:tcp_udp_client_app/features/tcp_client/domain/message.dart";

class MessageItem extends StatelessWidget {
  final Message message;
  const MessageItem(
    this.message, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isServer ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: message.isServer
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Text(
                message.isServer ? "Server" : "You",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              Text(
                message.message,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
