// ignore_for_file: avoid_redundant_argument_values

import "dart:convert";
import "dart:io";
import "dart:typed_data";

import "package:equatable/equatable.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tcp_udp_client_app/features/tcp_client/domain/message.dart";

part "tcp_state.dart";

class TcpCubit extends Cubit<TcpState> {
  Socket? tcpSocket;

  TcpCubit() : super(TcpState.empty());

  void changeHost(InternetAddress host) {
    emit(state.copyWith(
      host: host,
      error: null,
    ));
  }

  Future<void> connect() async {
    emit(state.copyWith(isConnecting: true));
    try {
      late Stream<dynamic> messageStream;

      await tcpSocket?.close();
      tcpSocket = await Socket.connect(state.host, state.port);
      if (tcpSocket == null) throw Exception("TCP socket is null");
      messageStream = tcpSocket! as Stream<Uint8List>;

      messageStream.cast<List<int>>().transform(utf8.decoder).listen((message) {
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
        error: () => null,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        isConnected: false,
        error: () => "Connection error: $e",
      ));
    } finally {
      emit(state.copyWith(
        isConnecting: false,
      ));
    }
  }

  void changePort(String port) {
    final portNumber = int.tryParse(port);

    if (portNumber == null) {
      emit(state.copyWith(error: () => "Invalid port"));
    }

    emit(state.copyWith(
      port: portNumber,
      error: null,
    ));
  }

  Future<void> dispose() async {
    if (state.isConnected) {
      await tcpSocket?.close();
    }
  }

  bool sendMessage(String message) {
    if (state.isConnected) {
      tcpSocket?.write(message);

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
      emit(state.copyWith(error: () => "Not connected"));
      return false;
    }
  }

  void clearMessages() {
    emit(state.copyWith(messages: []));
  }
}
