import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'data.dart';
import 'halaman_katalog.dart';

class HalamanKategori extends StatelessWidget {
  const HalamanKategori({super.key, required this.nama});
  final String nama;
  @override
  Widget build(BuildContext context) {
    final hasil = daftarProduk
        .where((p) => p.kategori.toLowerCase() == nama.toLowerCase())
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text('Kategori: $nama')),
      body: hasil.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Kategori tidak ditemukan'),
                  TextButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Kembali ke katalog'),
                  ),
                ],
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                final kolom = switch (constraints.maxWidth) {
                  < 600 => 2,
                  < 900 => 3,
                  _ => 4,
                };
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: hasil.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kolom,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, i) => KartuProduk(produk: hasil[i]),
                );
              },
            ),
    );
  }
}
