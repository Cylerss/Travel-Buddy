import 'package:flutter_test/flutter_test.dart';
import 'package:travel_buddy/main.dart';

void main() {
  testWidgets('TravelBuddy App Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelBuddyApp());
    expect(find.byType(TravelBuddyApp), findsOneWidget);
  });
}
