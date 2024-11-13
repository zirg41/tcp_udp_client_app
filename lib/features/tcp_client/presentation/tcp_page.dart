import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:tcp_udp_client_app/features/tcp_client/bloc/tcp_cubit.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/app_error_widget.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/connecting_button.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/host_port_text_fields.dart";
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
    hostController.text = state.host.address;
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
                  HostPortTextFields(
                    hostController: hostController,
                    onEditingHostComplete: () {
                      context.read<TcpCubit>().changeHost(
                            InternetAddress(hostController.text),
                          );
                    },
                    portController: portController,
                    onEditingPortComplete: () {
                      context.read<TcpCubit>().changePort(portController.text);
                    },
                  ),
                  const SizedBox(height: 8),
                  ConnectingButton(
                    connectedAddress: state.host.address,
                    connectedPort: state.port,
                    isConnected: state.isConnected,
                    isConnecting: state.isConnecting,
                    onConnect: () => context.read<TcpCubit>().connect(),
                  ),
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
