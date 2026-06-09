import 'package:flutter_test/flutter_test.dart';
import 'package:gobis/app.dart';

void main() {
  testWidgets('GoBis app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GoBisApp());
    await tester.pumpAndSettle();
    expect(find.text('Bis'), findsOneWidget);
  });
}
