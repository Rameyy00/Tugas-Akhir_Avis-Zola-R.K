import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project_1/main.dart';

void main() {
  testWidgets('Teks 0 muncul setelah aksi reset', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 1. Cari tombol reset
    final buttonFinder = find.byKey(const Key('reset_button'));

    // 2. Tekan tombol reset
    await tester.tap(buttonFinder);

    // 3. Bangun ulang widget
    await tester.pump();

    // 4. Verifikasi hasil
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });

  testWidgets('Teks 1 muncul setelah menekan tombol tambah', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 1. Tekan tombol tambah
    await tester.tap(find.byIcon(Icons.add));

    // 2. Bangun ulang widget
    await tester.pump();

    // 3. Verifikasi hasil
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}