// ignore_for_file: avoid_redundant_argument_values

import "dart:convert";
import "dart:io";
import "dart:typed_data";

import "package:equatable/equatable.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tcp_udp_client_app/features/tcp_client/domain/connection_mode.dart";
import "package:tcp_udp_client_app/features/tcp_client/domain/message.dart";

part "tcp_state.dart";

class TcpCubit extends Cubit<TcpState> {
  Socket? tcpSocket;
  RawDatagramSocket? udpSocket;
  final ConnectionMode connectionMode;

  TcpCubit(this.connectionMode) : super(TcpState.empty());

  void changeHost(String host) {
    emit(state.copyWith(
      host: host,
      error: null,
    ));
  }

  Future<void> connect() async {
    emit(state.copyWith(isConnecting: true));
    try {
      late Stream<dynamic> messageStream;

      if (connectionMode == ConnectionMode.tcp) {
        udpSocket?.close();
        tcpSocket = await Socket.connect(state.host, state.port);
        if (tcpSocket == null) throw Exception("TCP socket is null");
        messageStream = tcpSocket! as Stream<Uint8List>;
      } else {
        await tcpSocket?.close();
        udpSocket = await RawDatagramSocket.bind(state.host, state.port);
        if (udpSocket == null) throw Exception("UDP socket is null");
        messageStream = udpSocket! as Stream<RawSocketEvent>;
      }

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

  void dispose() {
    if (state.isConnected) {
      tcpSocket?.close();
    }
  }

  bool sendMessage(String message) {
    if (state.isConnected) {
      if (connectionMode == ConnectionMode.tcp) {
        tcpSocket?.write(message);
      } else {
        udpSocket?.send(
          utf8.encode(message),
          InternetAddress(state.host),
          state.port + 1,
        );
      }

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
