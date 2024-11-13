import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/app_error_widget.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/connecting_button.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/host_port_text_fields.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/message_text_field.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/widgets/messages_list_view.dart";
import "package:tcp_udp_client_app/features/udp_client/bloc/udp_cubit.dart";

class UdpPage extends StatefulWidget {
  const UdpPage({
    super.key,
  });

  @override
  State<UdpPage> createState() => _UdpPageState();
}

class _UdpPageState extends State<UdpPage> {
  final hostController = TextEditingController();
  final devicePortController = TextEditingController();
  final serverPortController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<UdpCubit>().state;
    hostController.text = state.serverIP.address;
    devicePortController.text = state.devicePort.toString();
    serverPortController.text = state.serverPort.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UDP Client"),
      ),
      body: SafeArea(
        child: BlocBuilder<UdpCubit, UdpState>(
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
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Select device IP:"),
                                DropdownButton(
                                  value: state.deviceIP,
                                  items: state.deviceAddresses
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e.address,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      context
                                          .read<UdpCubit>()
                                          .changeDeviceIP(value);
                                    }
                                  },
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () => context
                                  .read<UdpCubit>()
                                  .initializeDeviceIPs(),
                              icon: const Icon(Icons.replay),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: TextField(
                          controller: devicePortController,
                          decoration: const InputDecoration(
                            labelText: "Device PORT",
                          ),
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          onEditingComplete: () {
                            context
                                .read<UdpCubit>()
                                .changeDevicePort(devicePortController.text);
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  HostPortTextFields(
                    hostController: hostController,
                    onEditingHostComplete: () {
                      context.read<UdpCubit>().changeDeviceIP(
                            InternetAddress(hostController.text),
                          );
                    },
                    portController: serverPortController,
                    onEditingPortComplete: () {
                      context
                          .read<UdpCubit>()
                          .changeDevicePort(serverPortController.text);
                    },
                  ),
                  const SizedBox(height: 8),
                  ConnectingButton(
                    connectedAddress: state.deviceIP.address,
                    connectedPort: state.devicePort,
                    isConnected: state.isConnected,
                    isConnecting: state.isConnecting,
                    onConnect: () => context.read<UdpCubit>().connect(),
                  ),
                  const SizedBox(height: 8),
                  if (state.error != null) AppErrorWidget(state.error!),
                  const SizedBox(height: 8),
                  Expanded(
                    child: MessagesListView(
                      messages: state.messages.reversed.toList(),
                      onClear: () => context.read<UdpCubit>().clearMessages(),
                    ),
                  ),
                  MessageTextField(
                    messageController: messageController,
                    onSend: () {
                      final success = context
                          .read<UdpCubit>()
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
