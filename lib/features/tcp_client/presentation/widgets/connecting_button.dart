import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tcp_udp_client_app/features/tcp_client/bloc/tcp_cubit.dart";

class ConnectingButton extends StatelessWidget {
  const ConnectingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TcpCubit, TcpState>(
      builder: (context, state) {
        return Row(
          children: [
            FilledButton(
              onPressed: () {
                context.read<TcpCubit>().connect();
              },
              child: const Text("connect"),
            ),
            const SizedBox(width: 8),
            if (!state.isConnecting)
              Text(
                "Is connected: ${state.isConnected}",
              ),
            if (state.isConnecting) ...[
              const Text(
                "Connecting",
              ),
              const SizedBox(width: 8),
              const CircularProgressIndicator.adaptive()
            ]
          ],
        );
      },
    );
  }
}
