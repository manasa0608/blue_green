// main.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

part 'main.g.dart';

// Providers are defined by annotating a function with @riverpod
@riverpod
String label(LabelRef ref) => 'Hello world';

void main() {
  runApp(ProviderScope(child: Home()));
}

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        // We can then listen to the generated provider in our widgets.
        body: Text(ref.watch(labelProvider)),
      ),
    );
  }
}
