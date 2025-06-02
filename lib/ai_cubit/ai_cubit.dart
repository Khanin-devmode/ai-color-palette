import 'package:ai_color_palette/ai_cubit/ai_agent.dart';
import 'package:ai_color_palette/ai_cubit/ai_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiCubit extends Cubit<AiState> {
  final agent = AiAgent();

  AiCubit() : super(AiInitial());

  void sendPrompt(String inputMessage) async {
    emit(AiLoading());

    try {
      final response = await agent.sendPrompt(inputMessage);

      emit(AiLoaded(message: response.text as String));
    } catch (e) {
      emit(AiError(errorMessage: 'An error occurred: $e'));
    }
  }
}
