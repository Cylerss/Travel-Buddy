import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_buddy/views/screen_02_welcome.dart';

void main() {
  testWidgets('Welcome screen renders all 3 slides without overflow', (WidgetTester tester) async {
    // Standard phone dimensions (iPhone 14/15: 393 x 852)
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    String? navigatedRoute;
    await tester.pumpWidget(
      MaterialApp(
        home: Screen02Welcome(
          onNavigate: (route) => navigatedRoute = route,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Slide 1: Discover Vizag
    expect(find.text('Discover Vizag'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);

    // Tap Continue to advance to Slide 2
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Slide 2: Explore trails & safe companions
    expect(find.text('Explore trails &\nsafe companions'), findsOneWidget);

    // Tap Continue to advance to Slide 3
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Slide 3: Go to gatherings
    expect(find.text('Go to gatherings'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap Get Started on Slide 3 to navigate to login
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(navigatedRoute, equals('03-traveller-login'));
  });

  testWidgets('Welcome screen skip button works directly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    String? navigatedRoute;
    await tester.pumpWidget(
      MaterialApp(
        home: Screen02Welcome(
          onNavigate: (route) => navigatedRoute = route,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(navigatedRoute, equals('03-traveller-login'));
  });

  testWidgets('Welcome screen renders cleanly on compact 360x640 screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: Screen02Welcome(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Discover Vizag'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Explore trails &\nsafe companions'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Go to gatherings'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
