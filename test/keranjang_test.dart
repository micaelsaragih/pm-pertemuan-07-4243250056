import 'package:flutter_test/flutter_test.dart';
import 'package:pm_pertemuan_07_4243250056/data.dart';
import 'package:pm_pertemuan_07_4243250056/keranjang_model.dart';

void main() {
  test('tambah memperbarui jumlah, total, dan memanggil listener', () {
    final k = KeranjangModel();
    var panggilan = 0;
    k.addListener(() => panggilan++);
    k.tambah(daftarProduk[0]);
    k.tambah(daftarProduk[0]);
    k.tambah(daftarProduk[1]);
    expect(k.jumlahItem, 3);
    expect(k.total, 170000);
    expect(panggilan, 3);
    k.dispose();
  });
  test('kurangi menghapus item ketika jumlah mencapai nol', () {
    final k = KeranjangModel();
    k.tambah(daftarProduk[0]);
    k.tambah(daftarProduk[0]);
    k.kurangi(daftarProduk[0]);
    expect(k.jumlahDari(1), 1);
    k.kurangi(daftarProduk[0]);
    expect(k.jumlahItem, 0);
    expect(k.item, isEmpty);
    k.dispose();
  });
  test('checkout simulasi mengosongkan keranjang', () {
    final k = KeranjangModel();
    k.tambah(daftarProduk[2]);
    k.kosongkan();
    expect(k.total, 0);
    expect(k.jumlahItem, 0);
    k.dispose();
  });
}
