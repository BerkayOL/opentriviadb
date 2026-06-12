import 'package:flutter_test/flutter_test.dart';
import 'package:opentriviadb/app/app.dart';

void main() {
  testWidgets('shows quiz setup page', (WidgetTester tester) async {
    await tester.pumpWidget(const TriviaQuizApp());

    expect(find.text('Trivia Quiz'), findsWidgets);
    expect(find.text('Start Quiz'), findsOneWidget);
  });
}
