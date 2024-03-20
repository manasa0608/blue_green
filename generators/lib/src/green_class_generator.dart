import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotation.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class GreenGenerator extends GeneratorForAnnotation<ChangeColor> {
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    final classAssetId = buildStep.inputId;
    var classContent = await buildStep.readAsString(classAssetId);

    final modelVisitor = ModelVisitor();
    element.visitChildren(modelVisitor);

    classContent = classContent.replaceAll(modelVisitor.className, '${modelVisitor.className}Green');
    classContent = classContent.replaceAll('@Green', '');
    classContent = classContent.replaceAll(RegExp(r"part\s*'[^']*\.g\.dart';"), '');
    final lines = classContent.split('\n');

    // Remove all import statements
    lines.removeWhere((line) => line.trim().startsWith('import'));

    // Join the lines back to a single string
    classContent = lines.join('\n');
    for (int i = 0; i < modelVisitor.fields.length; i++) {
      classContent = classContent.replaceAll(modelVisitor.fields.keys.elementAt(i), '${modelVisitor.fields.keys.elementAt(i)}');
    }

    for (int i = 0; i < modelVisitor.functions.length; i++) {
      classContent = classContent.replaceAll(modelVisitor.functions.elementAt(i), '${modelVisitor.functions.elementAt(i)}');
    }
    return '$classContent';
  }
}
