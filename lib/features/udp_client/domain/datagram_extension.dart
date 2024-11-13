import "dart:io";

extension DatagramX on Datagram? {
  String get logString =>
      "Datagram(\ndata: ${this?.data},\naddress: ${this?.address},\nport: ${this?.port})";
}
