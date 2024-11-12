import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:tcp_udp_client_app/features/tcp_client/bloc/tcp_cubit.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/app_error_widget.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/connecting_button.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/message_text_field.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/messages_list_view.dart";

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
    return Scaffold(
      appBar: AppBar(title: const Text("TCP Client")),
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
                  const ConnectingButton(),
                  const SizedBox(height: 8),
                  if (state.error != null) AppErrorWidget(state.error!),
                  const SizedBox(height: 8),
                  Expanded(
                    child: MessagesListView(
                      messages: state.messages.reversed.toList(),
                      onClear: () => context.read<TcpCubit>().clearMessages(),
                    ),
                  ),
                  MessageTextField(
                    messageController: messageController,
                    onSend: () {
                      final success = context
                          .read<TcpCubit>()
                          .sendMessage(messageController.text);
                      if (success) {
                        messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
