import 'package:flutter_bloc/flutter_bloc.dart';
import 'data.dart';

class ItemKeranjang {
  const ItemKeranjang(this.produk, this.jumlah);
  final Produk produk;
  final int jumlah;
  int get subtotal => produk.harga * jumlah;
}

/// State value baru tiap perubahan; map disalin dan tidak diekspos sebagai mutable.
class KeranjangState {
  KeranjangState([Map<int, int> isi = const {}, this.checkoutRevision = 0])
      : isi = Map.unmodifiable(isi);
  final Map<int, int> isi;
  final int checkoutRevision;
  List<ItemKeranjang> get item => [
    for (final entry in isi.entries)
      if (cariProduk(entry.key) case final Produk produk)
        ItemKeranjang(produk, entry.value),
  ];
  int get jumlahItem => isi.values.fold(0, (a, b) => a + b);
  int get total => item.fold(0, (a, b) => a + b.subtotal);
  int jumlahDari(int id) => isi[id] ?? 0;
}

class KeranjangCubit extends Cubit<KeranjangState> {
  KeranjangCubit() : super(KeranjangState());

  void tambah(Produk p) {
    final baru = Map<int, int>.of(state.isi)
      ..update(p.id, (n) => n + 1, ifAbsent: () => 1);
    emit(KeranjangState(baru, state.checkoutRevision));
  }

  void kurangi(Produk p) {
    final n = state.isi[p.id];
    if (n == null) return;
    final baru = Map<int, int>.of(state.isi);
    if (n <= 1) { baru.remove(p.id); } else { baru[p.id] = n - 1; }
    emit(KeranjangState(baru, state.checkoutRevision));
  }

  void kosongkan() {
    if (state.isi.isEmpty) return;
    emit(KeranjangState(const {}, state.checkoutRevision));
  }

  void checkout() {
    if (state.isi.isEmpty) return;
    emit(KeranjangState(const {}, state.checkoutRevision + 1));
  }
}
