import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'keranjang_model.dart';

class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});
  @override
  Widget build(BuildContext context) {
    final keranjang = context.watch<KeranjangModel>();
    final items = keranjang.item;
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: items.isEmpty
        ? const Center(child: Text('Keranjang masih kosong'))
        : ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: Icon(item.produk.ikon, color: item.produk.warna),
                title: Text(item.produk.nama, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text('Subtotal ${item.subtotal.rupiah}'),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(tooltip: 'Kurangi ${item.produk.nama}',
                    onPressed: () => context.read<KeranjangModel>().kurangi(item.produk),
                    icon: const Icon(Icons.remove)),
                  Text('${item.jumlah}'),
                  IconButton(tooltip: 'Tambah ${item.produk.nama}',
                    onPressed: () => context.read<KeranjangModel>().tambah(item.produk),
                    icon: const Icon(Icons.add)),
                ]),
              );
            }),
      bottomNavigationBar: items.isEmpty ? null : SafeArea(child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: Text('Total ${keranjang.total.rupiah}',
            style: Theme.of(context).textTheme.titleMedium)),
          FilledButton(onPressed: () {
            context.read<KeranjangModel>().kosongkan();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pesanan dibuat (simulasi)')));
          }, child: const Text('Checkout')),
        ]),
      )),
    );
  }
}
