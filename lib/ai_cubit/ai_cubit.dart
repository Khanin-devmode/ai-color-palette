import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiCubit extends Cubit<String> {
  // Initialize the Gemini Developer API backend service
  // Create a `GenerativeModel` instance with a model that supports your use case
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.0-flash',
  );

  AiCubit() : super('');

  void sendPrompt(String prompt) {
    emit('some result');
  }
}
