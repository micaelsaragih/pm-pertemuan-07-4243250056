import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'data.dart';

class HalamanKatalog extends StatefulWidget {
  const HalamanKatalog({super.key});
  @override
  State<HalamanKatalog> createState() => _HalamanKatalogState();
}

class _HalamanKatalogState extends State<HalamanKatalog> {
  String kategoriAktif = 'Semua';
  static const kategori = ['Semua', 'Minuman', 'Kue', 'Camilan'];

  @override
  Widget build(BuildContext context) {
    final hasil = daftarProduk
        .where((p) => kategoriAktif == 'Semua' || p.kategori == kategoriAktif)
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Oleh-Oleh Medan')),
      body: Column(
        children: [
          SizedBox(
            height: 64,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                for (final item in kategori)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(item),
                      selected: kategoriAktif == item,
                      onSelected: (_) => setState(() => kategoriAktif = item),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final kolom = switch (constraints.maxWidth) {
                  < 600 => 2,
                  < 900 => 3,
                  _ => 4,
                };
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kolom,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: constraints.maxWidth < 420 ? 0.72 : 0.8,
                  ),
                  itemCount: hasil.length,
                  itemBuilder: (context, i) => KartuProduk(produk: hasil[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class KartuProduk extends StatelessWidget {
  const KartuProduk({super.key, required this.produk});
  final Produk produk;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final fallback = ColoredBox(
      color: produk.warna.withValues(alpha: 0.15),
      child: SizedBox.expand(
        child: Icon(produk.ikon, size: 56, color: produk.warna),
      ),
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('/produk/${produk.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'produk-${produk.id}',
                child: produk.gambar != null
                    ? Image.asset(
                        produk.gambar!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) => fallback,
                      )
                    : fallback,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    style: teks.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    produk.harga.rupiah,
                    style: teks.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
