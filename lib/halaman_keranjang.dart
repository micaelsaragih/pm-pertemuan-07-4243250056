import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'data.dart';
import 'keranjang_cubit.dart';

class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KeranjangCubit, KeranjangState>(
      listenWhen: (sebelum, sesudah) =>
          sesudah.checkoutRevision > sebelum.checkoutRevision,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pesanan dibuat (simulasi)')),
        );
      },
      builder: (context, state) {
        final items = state.item;
        return Scaffold(
          appBar: AppBar(title: const Text('Keranjang')),
          body: items.isEmpty
              ? const Center(child: Text('Keranjang masih kosong'))
              : ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Icon(item.produk.ikon, color: item.produk.warna),
                      title: Text(
                        item.produk.nama,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text('Subtotal ${item.subtotal.rupiah}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Kurangi ${item.produk.nama}',
                            onPressed: () => context
                                .read<KeranjangCubit>()
                                .kurangi(item.produk),
                            icon: const Icon(Icons.remove),
                          ),
                          Text('${item.jumlah}'),
                          IconButton(
                            tooltip: 'Tambah ${item.produk.nama}',
                            onPressed: () => context
                                .read<KeranjangCubit>()
                                .tambah(item.produk),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          bottomNavigationBar: items.isEmpty
              ? null
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total ${state.total.rupiah}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        FilledButton(
                          onPressed: () =>
                              context.read<KeranjangCubit>().checkout(),
                          child: const Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
