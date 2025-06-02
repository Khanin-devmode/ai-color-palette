import 'package:ai_color_palette/ai_cubit/ai_agent.dart';
import 'package:ai_color_palette/ai_cubit/ai_state.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiCubit extends Cubit<AiState> {
  final agent = AiAgent();

  AiCubit() : super(AiInitial());

  void sendPrompt(String inputMessage) async {
    emit(AiLoading());

    try {
      final response = await agent.sendPrompt(inputMessage);

      if (response.functionCalls.isNotEmpty) {
        final functionCall = response.functionCalls.first;
        switch (functionCall.name) {
          case 'generateColorPalette':
            await setColorPaletteCall(functionCall);
          default:
            throw UnimplementedError(
              'Function not declared to the model: ${functionCall.name}',
            );
        }
      }

      emit(AiLoaded(message: response.text as String));
    } catch (e) {
      emit(AiError(errorMessage: 'An error occurred: $e'));
    }
  }
}

Future<void> setColorPaletteCall(FunctionCall functionCall) async {
  String color_0 = functionCall.args['color_0'] as String;
  String color_1 = functionCall.args['color_1'] as String;
  String color_2 = functionCall.args['color_2'] as String;
  String color_3 = functionCall.args['color_3'] as String;
  String color_4 = functionCall.args['color_4'] as String;

  print(color_0);
  print(color_1);
  print(color_2);
  print(color_3);
  print(color_4);
}
