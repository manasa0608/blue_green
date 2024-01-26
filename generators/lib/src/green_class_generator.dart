import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotation.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:generators/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

class GreenClassGenerator extends GeneratorForAnnotation<ChangeColor> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final classAssetId = buildStep.inputId;
    var classContent = await buildStep.readAsString(classAssetId);

    final modelVisitor = ModelVisitor();
    element.visitChildren(modelVisitor);

    classContent = classContent.replaceAll(
        modelVisitor.className, 'Green${modelVisitor.className}');

    for (int i = 0; i < modelVisitor.fields.length; i++) {
      classContent = classContent.replaceAll(
          modelVisitor.fields.keys.elementAt(i),
          'green${modelVisitor.fields.keys.elementAt(i)}');
    }

    for (int i = 0; i < modelVisitor.functions.length; i++) {
      classContent = classContent.replaceAll(
          modelVisitor.functions.elementAt(i),
          'green${modelVisitor.functions.elementAt(i)}');
    }
    return '$classContent';
  }
}
