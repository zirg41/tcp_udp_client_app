import "package:flutter/material.dart";

class ConnectingButton extends StatelessWidget {
  final VoidCallback onConnect;
  final bool isConnecting;
  final bool isConnected;
  final String connectedAddress;
  final int connectedPort;

  const ConnectingButton({
    required this.onConnect,
    required this.isConnecting,
    required this.isConnected,
    required this.connectedAddress,
    required this.connectedPort,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilledButton(
          onPressed: onConnect,
          child: const Text("connect"),
        ),
        const SizedBox(width: 8),
        if (!isConnecting)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Is connected: $isConnected",
              ),
              if (isConnected)
                Text(
                  "Socket: $connectedAddress:$connectedPort",
                ),
            ],
          ),
        if (isConnecting) ...[
          const Text(
            "Connecting",
          ),
          const SizedBox(width: 8),
          const CircularProgressIndicator.adaptive()
        ]
      ],
    );
  }
}
