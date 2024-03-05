library generators;

import 'package:build/build.dart';
import 'package:generators/src/green_class_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateGreenClass(BuilderOptions options) => SharedPartBuilder(
      [GreenGenerator()],
      'green_class_generator',
    );
