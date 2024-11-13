part of "udp_cubit.dart";

final class UdpState extends Equatable {
  final InternetAddress deviceIP;
  final InternetAddress serverIP;
  final int devicePort;
  final int serverPort;
  final String? error;
  final List<Message> messages;
  final bool isConnected;
  final bool isConnecting;
  final List<InternetAddress> deviceAddresses;

  const UdpState(
      {required this.deviceIP,
      required this.serverIP,
      required this.devicePort,
      required this.serverPort,
      required this.messages,
      required this.isConnected,
      required this.isConnecting,
      required this.deviceAddresses,
      this.error});

  factory UdpState.empty() => UdpState(
        deviceIP: InternetAddress("127.0.0.1"),
        serverIP: InternetAddress("192.168.0.64"),
        devicePort: 8084,
        serverPort: 8083,
        messages: const [],
        isConnected: false,
        isConnecting: false,
        deviceAddresses: const [],
      );

  @override
  List<Object?> get props => [
        deviceIP,
        error,
        serverIP,
        serverPort,
        devicePort,
        messages,
        isConnected,
        isConnecting,
        deviceAddresses
      ];

  UdpState copyWith({
    InternetAddress? deviceIP,
    InternetAddress? serverIP,
    ValueGetter<String?>? error,
    int? devicePort,
    int? serverPort,
    List<Message>? messages,
    bool? isConnected,
    bool? isConnecting,
    List<InternetAddress>? deviceAddresses,
  }) {
    return UdpState(
      deviceIP: deviceIP ?? this.deviceIP,
      serverIP: serverIP ?? this.serverIP,
      error: error != null ? error() : this.error,
      devicePort: devicePort ?? this.devicePort,
      serverPort: serverPort ?? this.serverPort,
      messages: messages ?? this.messages,
      isConnected: isConnected ?? this.isConnected,
      deviceAddresses: deviceAddresses ?? this.deviceAddresses,
      isConnecting: isConnecting ?? this.isConnecting,
    );
  }
}
