import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:pm_pertemuan_07_4243250056/main.dart';
import 'package:pm_pertemuan_07_4243250056/keranjang_model.dart';

void main() {
  testWidgets('Katalog dan filter kategori', (tester) async {
    tester.view.physicalSize = const Size(480, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (_) => KeranjangModel(), child: const KatalogApp()));
    await tester.pumpAndSettle();
    expect(find.text('Kopi Sidikalang'), findsOneWidget);
    await tester.tap(find.text('Kue'));
    await tester.pumpAndSettle();
    expect(find.text('Bika Ambon'), findsOneWidget);
    expect(find.text('Kopi Sidikalang'), findsNothing);
  });

  testWidgets('Halaman detail membuka tombol tambah keranjang', (tester) async {
    tester.view.physicalSize = const Size(480, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (_) => KeranjangModel(), child: const KatalogApp()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kopi Sidikalang'));
    await tester.pumpAndSettle();
    expect(find.text('Tambah ke keranjang'), findsOneWidget);
  });

  testWidgets('NavigationRail muncul pada layar lebar', (tester) async {
    tester.view.physicalSize = const Size(1100, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (_) => KeranjangModel(), child: const KatalogApp()));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationRail), findsOneWidget);
  });
}
