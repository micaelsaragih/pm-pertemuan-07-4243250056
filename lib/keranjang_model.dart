import 'package:flutter/foundation.dart';
import 'data.dart';

class ItemKeranjang {
  const ItemKeranjang(this.produk, this.jumlah);
  final Produk produk;
  final int jumlah;
  int get subtotal => produk.harga * jumlah;
}

class KeranjangModel extends ChangeNotifier {
  final Map<int, int> _isi = {};
  List<ItemKeranjang> get item => [
    for (final entry in _isi.entries)
      if (cariProduk(entry.key) case final Produk produk)
        ItemKeranjang(produk, entry.value),
  ];
  int get jumlahItem => _isi.values.fold(0, (a, b) => a + b);
  int get total => item.fold(0, (sum, element) => sum + element.subtotal);
  int jumlahDari(int idProduk) => _isi[idProduk] ?? 0;
  void tambah(Produk produk) {
    _isi.update(produk.id, (n) => n + 1, ifAbsent: () => 1);
    notifyListeners();
  }
  void kurangi(Produk produk) {
    final jumlah = _isi[produk.id];
    if (jumlah == null) return;
    if (jumlah == 1) { _isi.remove(produk.id); } else { _isi[produk.id] = jumlah - 1; }
    notifyListeners();
  }
  void kosongkan() {
    if (_isi.isEmpty) return;
    _isi.clear();
    notifyListeners();
  }
}
