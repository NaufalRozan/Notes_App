import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/main.dart';

void main() {
  testWidgets('Renders NoteList widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SimpleNotesApp());

    // Verify that our NoteList widget is rendered.
    expect(find.byType(NoteList), findsOneWidget);
  });

  testWidgets('Adds and deletes a note', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SimpleNotesApp());

    // Verify that the NoteList widget initially has no notes.
    expect(find.byType(ListTile), findsNothing);

    // Tap the add note button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Add New Note'), findsOneWidget);

    // Enter note details and tap the save button.
    await tester.enterText(
        find.widgetWithText(TextField, 'Title'), 'Test Title');
    await tester.enterText(
        find.widgetWithText(TextField, 'Contents of Note'), 'Test Content');
    await tester.tap(find.text('Save'));
    await tester.pump();

    // Verify that the NoteList widget now has one note.
    expect(find.byType(ListTile), findsOneWidget);

    // Tap the delete icon.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Verify that the NoteList widget no longer has any notes.
    expect(find.byType(ListTile), findsNothing);
  });
}
