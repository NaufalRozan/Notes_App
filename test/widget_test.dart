import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/main.dart';

void main() {
  testWidgets('Renders NoteList widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SimpleNotesApp());

    // Verify that our NoteList widget is rendered.
    expect(find.byType(NoteList), findsOneWidget);
  });
}
