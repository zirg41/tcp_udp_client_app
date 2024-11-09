// ignore_for_file: avoid_redundant_argument_values

import "dart:convert";
import "dart:io";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";
import "package:tcp_udp_client_app/features/tcp_client/domain/message.dart";

part "tcp_state.dart";

@Singleton()
class TcpCubit extends Cubit<TcpState> {
  Socket? socket;
  TcpCubit() : super(TcpState.empty());

  void changeHost(String host) {
    emit(state.copyWith(
      host: host,
      error: null,
    ));
  }

  Future<void> connect() async {
    emit(state.copyWith(isConnecting: true));
    try {
      socket = await Socket.connect(state.host, state.port);

      socket?.cast<List<int>>().transform(utf8.decoder).listen((message) {
        emit(
          state.copyWith(
            messages: [
              ...state.messages,
              Message(isServer: true, message: message),
            ],
            isConnected: true,
            isConnecting: false,
          ),
        );
      });
      emit(state.copyWith(
        isConnected: true,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(isConnected: false, error: "Connection error: $e"));
    } finally {
      emit(state.copyWith(
        isConnecting: false,
      ));
    }
  }

  void changePort(String port) {
    final portNumber = int.tryParse(port);

    if (portNumber == null) {
      emit(state.copyWith(error: "Invalid port"));
    }

    emit(state.copyWith(
      port: portNumber,
      error: null,
    ));
  }

  void dispose() {
    socket?.close();
  }

  bool sendMessage(String message) {
    if (state.isConnected) {
      socket?.write(message);
      emit(
        state.copyWith(
          messages: [
            ...state.messages,
            Message(isServer: false, message: message),
          ],
          isConnected: true,
          isConnecting: false,
        ),
      );
      return true;
    } else {
      emit(state.copyWith(error: "Not connected"));
      return false;
    }
  }

  void clearMessages() {
    emit(state.copyWith(messages: []));
  }
}
