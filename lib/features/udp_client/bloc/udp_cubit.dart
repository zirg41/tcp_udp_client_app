// ignore_for_file: avoid_redundant_argument_values

import "dart:convert";
import "dart:io";

import "package:equatable/equatable.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tcp_udp_client_app/core/utils/logger.dart";
import "package:tcp_udp_client_app/features/tcp_client/domain/message.dart";
import "package:tcp_udp_client_app/features/udp_client/domain/datagram_extension.dart";

part "udp_state.dart";

class UdpCubit extends Cubit<UdpState> {
  RawDatagramSocket? udpSocket;

  UdpCubit() : super(UdpState.empty());

  void changeDeviceIP(InternetAddress ip) {
    udpSocket?.close();
    emit(state.copyWith(
      deviceIP: ip,
      isConnected: false,
      error: null,
    ));
  }

  void changeServerIP(InternetAddress ip) {
    udpSocket?.close();
    emit(state.copyWith(
      serverIP: ip,
      isConnected: false,
      error: null,
    ));
  }

  void changeDevicePort(String port) {
    udpSocket?.close();
    final portNumber = int.tryParse(port);

    if (portNumber == null) {
      emit(state.copyWith(error: () => "Invalid port"));
    }

    emit(state.copyWith(
      devicePort: portNumber,
      isConnected: false,
      error: null,
    ));
  }

  void changeServerPort(String port) {
    udpSocket?.close();
    final portNumber = int.tryParse(port);

    if (portNumber == null) {
      emit(state.copyWith(error: () => "Invalid port"));
    }

    emit(state.copyWith(
      serverPort: portNumber,
      isConnected: false,
      error: null,
    ));
  }

  Future<void> connect() async {
    emit(state.copyWith(isConnecting: true));
    try {
      udpSocket?.close();
      udpSocket =
          await RawDatagramSocket.bind(state.deviceIP, state.devicePort);
      if (udpSocket == null) throw Exception("UDP socket is null");

      udpSocket?.listen((socketEvent) {
        logger.debug("socketEvent: $socketEvent");
        if (socketEvent == RawSocketEvent.read) {
          final Datagram? datagram = udpSocket?.receive();
          logger.debug("Got Datagram: ${datagram.logString}");
          emit(
            state.copyWith(
              messages: [
                ...state.messages,
                Message(isServer: true, message: datagram.logString),
              ],
              isConnected: true,
              isConnecting: false,
            ),
          );
        }
        if (socketEvent == RawSocketEvent.write) {
          logger.debug("RawSocketEvent.write");
        }
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

  void dispose() {
    if (state.isConnected) {
      udpSocket?.close();
    }
  }

  bool sendMessage(String message) {
    if (state.isConnected) {
      udpSocket?.send(
        utf8.encode(message),
        state.serverIP,
        state.serverPort,
      );

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

  Future<void> initializeDeviceIPs() async {
    final list = await NetworkInterface.list(
      includeLoopback: true,
    );
    final List<InternetAddress> listOfIPs = [];
    for (final netInterface in list) {
      if (netInterface.addresses.isNotEmpty) {
        listOfIPs.addAll(netInterface.addresses);
      }
    }

    listOfIPs
        .removeWhere((element) => element.type == InternetAddressType.IPv6);

    emit(state.copyWith(
      deviceAddresses: listOfIPs,
      deviceIP: listOfIPs.first,
    ));
  }
}
