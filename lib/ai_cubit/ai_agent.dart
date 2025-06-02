import 'package:firebase_ai/firebase_ai.dart';

class AiAgent {
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.0-flash',
  );

  Future<GenerateContentResponse> sendPrompt(String inputMessage) async {
    final prompt = [Content.text(inputMessage)];

    // To generate text output, call generateContent with the text input
    return await model.generateContent(prompt);
  }
}
