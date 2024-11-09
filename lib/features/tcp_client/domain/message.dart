import "package:equatable/equatable.dart";

class Message extends Equatable {
  final bool isServer;
  final String message;

  const Message({required this.isServer, required this.message});

  @override
  List<Object?> get props => [
        isServer,
        message,
      ];
}
