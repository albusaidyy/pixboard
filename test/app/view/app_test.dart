import 'package:flutter_test/flutter_test.dart';
import 'package:pixboard/app/app.dart';
import 'package:pixboard/features/dashboard/dashboard.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(DashBoardPage), findsOneWidget);
    });
  });
}
