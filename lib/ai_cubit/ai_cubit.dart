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
            final colors = await setColorPaletteCall(functionCall);
            emit(AiLoaded(message: response.text ?? '', colors: colors));
            break;
          default:
            throw UnimplementedError(
              'Function not declared to the model: ${functionCall.name}',
            );
        }
      }

      // emit(AiLoaded(message: response.text as String, colors: []));
    } catch (e) {
      emit(AiError(errorMessage: 'An error occurred: $e'));
    }
  }
}

// Function to parse color palette from function call
Future<List<int>> setColorPaletteCall(FunctionCall functionCall) async {
  print('Original color_0: ' + (functionCall.args['color_0'] as String));
  print('Original color_1: ' + (functionCall.args['color_1'] as String));
  print('Original color_2: ' + (functionCall.args['color_2'] as String));
  print('Original color_3: ' + (functionCall.args['color_3'] as String));
  print('Original color_4: ' + (functionCall.args['color_4'] as String));
  int color_0 = int.parse((functionCall.args['color_0'] as String));
  int color_1 = int.parse((functionCall.args['color_1'] as String));
  int color_2 = int.parse((functionCall.args['color_2'] as String));
  int color_3 = int.parse((functionCall.args['color_3'] as String));
  int color_4 = int.parse((functionCall.args['color_4'] as String));

  print(color_0);
  print(color_1);
  print(color_2);
  print(color_3);
  print(color_4);
  return [color_0, color_1, color_2, color_3, color_4];
}
