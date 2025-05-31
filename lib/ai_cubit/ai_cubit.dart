import 'package:ai_color_palette/ai_cubit/ai_state.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiCubit extends Cubit<AiState> {
  // Initialize the Gemini Developer API backend service
  // Create a `GenerativeModel` instance with a model that supports your use case
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.0-flash',
  );

  AiCubit() : super(AiInitial());

  void sendPrompt(String inputMessage) async {
    emit(AiLoading());

    try {
      // Provide a prompt that contains text
      final prompt = [Content.text(inputMessage)];

      // To generate text output, call generateContent with the text input
      final response = await model.generateContent(prompt);

      emit(AiLoaded(message: response.text as String));
    } catch (e) {
      emit(AiError(errorMessage: 'An error occurred: $e'));
    }
  }
}
