import 'package:firebase_ai/firebase_ai.dart';

final generateColorPaletteTool = FunctionDeclaration(
  'generateColorPalette',
  'Generate a color palette consists of five colors that match the description, you should convert the color to the dart hexcode, e.g. 0xff000000 for black color, yourself.',
  parameters: {
    'color_0': Schema.string(
      description: 'First member of a color palette in hexcode format',
    ),
    'color_1': Schema.string(
      description: 'Second member of a color palette in hexcode format',
    ),
    'color_2': Schema.string(
      description: 'Third member of a color palette in hexcode format',
    ),
    'color_3': Schema.string(
      description: 'Fourth member of a color palette in hexcode format',
    ),
    'color_4': Schema.string(
      description: 'Fifth member of a color palette in hexcode format',
    ),
  },
);
