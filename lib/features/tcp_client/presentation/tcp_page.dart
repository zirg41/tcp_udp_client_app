import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tcp_udp_client_app/core/qa/flavor_banner.dart";
import "package:tcp_udp_client_app/core/utils/extensions/build_context_x.dart";
import "package:tcp_udp_client_app/features/tcp_client/bloc/tcp_cubit.dart";
import "package:tcp_udp_client_app/features/tcp_client/domain/message.dart";

class TcpPage extends StatefulWidget {
  const TcpPage({
    super.key,
  });

  @override
  State<TcpPage> createState() => _TcpPageState();
}

class _TcpPageState extends State<TcpPage> {
  final hostController = TextEditingController();
  final portController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<TcpCubit>().state;
    hostController.text = state.host;
    portController.text = state.port.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.tcpPageName)),
        body: SafeArea(
          child: BlocBuilder<TcpCubit, TcpState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Row(
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
                              context
                                  .read<TcpCubit>()
                                  .changeHost(hostController.text);
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
                              context
                                  .read<TcpCubit>()
                                  .changePort(portController.text);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        FilledButton(
                          onPressed: () {
                            context.read<TcpCubit>().connect();
                          },
                          child: Text("connect"),
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
                    ),
                    const SizedBox(height: 8),
                    Row(
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
                              context
                                  .read<TcpCubit>()
                                  .changePort(portController.text);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
                        ),
                        IconButton.filled(
                          onPressed: () {
                            final success = context
                                .read<TcpCubit>()
                                .sendMessage(messageController.text);
                            if (success) {
                              messageController.clear();
                            }
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (_, i) => MessageItem(state.messages[i]),
                        itemCount: state.messages.length,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.read<TcpCubit>().clearMessages(),
                      child: const Text("Clear"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

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
