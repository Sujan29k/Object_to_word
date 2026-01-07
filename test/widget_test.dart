import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:word_game/app.dart';
import 'package:word_game/state/game_provider.dart';

void main() {
  testWidgets('Game screen loads and shows loading indicator', (
    WidgetTester tester,
  ) async {
    // Arrange
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GameProvider()..init(),
        child: const App(),
      ),
    );

    // Assert loading indicator exists
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Let async loading complete
    await tester.pumpAndSettle();

    // After loading, Game UI should appear
    expect(find.textContaining('Level'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
