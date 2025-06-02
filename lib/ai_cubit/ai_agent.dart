import 'package:ai_color_palette/ai_cubit/ai_functions.dart';
import 'package:firebase_ai/firebase_ai.dart';

class AiAgent {
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.0-flash',
    tools: [
      Tool.functionDeclarations([generateColorPaletteTool]),
    ],
    systemInstruction: Content.text(
      'As a professional yet humble colorist and UX/UI designer, your task is to create harmonious and aesthetically pleasing color palettes. Each palette should consist of five colors that align with the given description, showcasing your expertise in color theory and design. If more information is requried please do not ask for the color code directly but creative generate it your own that related to users request.',
    ),
  );

  Future<GenerateContentResponse> sendPrompt(String inputMessage) async {
    final prompt = [Content.text(inputMessage)];

    // To generate text output, call generateContent with the text input
    return await model.generateContent(prompt);
  }
}
