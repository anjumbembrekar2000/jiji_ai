import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final String? userMessage;
  final String? botReply;
  final bool showRagActions;

  const ChatState({
    this.userMessage,
    this.botReply,
    this.showRagActions = false,
  });

  @override
  List<Object?> get props => [userMessage, botReply, showRagActions];
}
