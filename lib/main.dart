import 'package:ai_color_palette/ai_cubit/ai_cubit.dart';
import 'package:ai_color_palette/ai_cubit/ai_state.dart';
import 'package:ai_color_palette/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (context) => AiCubit(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter something',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Use the value from the text field
                    print('Submitted: ' + _textController.text);

                    context.read<AiCubit>().sendPrompt(_textController.text);
                  }
                },
                child: const Text('Submit'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          color: Color(0xFFDAA520),
                        ),
                        BlocBuilder<AiCubit, AiState>(
                          builder: (context, state) {
                            if (state is AiLoaded) {
                              return Column(
                                children: [
                                  Text(state.message),

                                  if (state.colors != null)
                                    Row(
                                      children: [
                                        for (int color in state.colors!)
                                          Expanded(
                                            child: Container(
                                              height: 50,
                                              color: Color(color),
                                            ),
                                          ),
                                      ],
                                    ),
                                ],
                              );
                            } else if (state is AiLoading) {
                              return CircularProgressIndicator();
                            } else if (state is AiError) {
                              return Text(state.errorMessage);
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
