import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'keranjang_model.dart';

class HalamanDetail extends StatelessWidget {
  const HalamanDetail({super.key, required this.produk});
  final Produk? produk;
  @override
  Widget build(BuildContext context) {
    final p = produk;
    if (p == null) {
      return Scaffold(appBar: AppBar(title: const Text('Produk tidak ditemukan')),
        body: Center(child: FilledButton(onPressed: () => context.go('/'),
          child: const Text('Kembali ke katalog'))));
    }
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;
    final diKeranjang = context.select((KeranjangModel k) => k.jumlahDari(p.id));
    final gambar = Hero(tag: 'produk-${p.id}', child: AspectRatio(aspectRatio: 4 / 3,
      child: ColoredBox(color: p.warna.withValues(alpha: 0.15),
        child: Center(child: Icon(p.ikon, size: 120, color: p.warna)))));
    final info = Padding(padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(p.nama, style: teks.headlineSmall),
        const SizedBox(height: 8),
        ActionChip(label: Text(p.kategori), onPressed: () =>
          context.go('/kategori/${Uri.encodeComponent(p.kategori)}')),
        const SizedBox(height: 8),
        Text(p.harga.rupiah, style: teks.titleLarge?.copyWith(color: skema.primary)),
        const SizedBox(height: 16),
        Text(p.deskripsi, style: teks.bodyLarge),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () => context.read<KeranjangModel>().tambah(p),
          icon: const Icon(Icons.add_shopping_cart),
          label: Text(diKeranjang == 0
            ? 'Tambah ke keranjang'
            : 'Tambah lagi ($diKeranjang di keranjang)'),
        ),
      ]));
    return Scaffold(appBar: AppBar(title: Text(p.nama)),
      body: LayoutBuilder(builder: (context, constraints) =>
        constraints.maxWidth >= 700
          ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: gambar),
              Expanded(child: SingleChildScrollView(child: info)),
            ])
          : ListView(children: [gambar, info]),
      ));
  }
}
