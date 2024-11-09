part of "tcp_cubit.dart";

final class TcpState extends Equatable {
  final String host;
  final String? error;
  final int port;
  final List<Message> messages;
  final bool isConnected;
  final bool isConnecting;

  const TcpState(
      {required this.host,
      required this.port,
      required this.messages,
      required this.isConnected,
      required this.isConnecting,
      this.error});

  factory TcpState.empty() => const TcpState(
        host: "192.168.0.64",
        port: 8084,
        messages: [],
        isConnected: false,
        isConnecting: false,
        error: null,
      );

  @override
  List<Object?> get props =>
      [host, error, port, messages, isConnected, isConnecting];

  TcpState copyWith({
    String? host,
    String? error,
    int? port,
    List<Message>? messages,
    bool? isConnected,
    bool? isConnecting,
  }) {
    return TcpState(
      host: host ?? this.host,
      error: error ?? this.error,
      port: port ?? this.port,
      messages: messages ?? this.messages,
      isConnected: isConnected ?? this.isConnected,
      isConnecting: isConnecting ?? this.isConnecting,
    );
  }
}
