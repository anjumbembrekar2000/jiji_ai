import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<SendMessageEvent>(_onSendMessage);
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) {
    final input = event.message.trim().toLowerCase();

    if (input == 'hi') {
      emit(ChatState(
        userMessage: event.message,
        botReply: 'Hello! How can I help you?',
      ));
    } else if (input == 'hello') {
      emit(ChatState(
        userMessage: event.message,
        botReply: 'Hi there! What would you like to learn today?',
      ));
    } else if (input == 'explain rag') {
      emit(ChatState(
        userMessage: event.message,
        botReply:
        'RAG (Retrieval-Augmented Generation) is an AI technique that combines information retrieval with generative models.\n\n'
            '• Retrieves relevant data from a knowledge source before generating a response.\n'
            '• Improves accuracy and reduces hallucinations in AI outputs.\n'
            '• Used in chatbots, enterprise search, and AI assistants.',
        showRagActions: true,
      ));
    } else {
      emit(ChatState(
        userMessage: event.message,
        botReply: 'I can respond only to: hi, hello, or explain rag.',
      ));
    }
  }
}
