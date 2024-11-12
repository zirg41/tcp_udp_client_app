enum ConnectionMode {
  tcp,
  udp;

  factory ConnectionMode.fromString(String string) => switch (string) {
        "TCP" => ConnectionMode.tcp,
        "UDP" => ConnectionMode.udp,
        _ => throw Exception("Unknown connection mode type: $string")
      };
  @override
  String toString() => switch (this) {
        ConnectionMode.tcp => "TCP",
        ConnectionMode.udp => "UDP",
      };
}
