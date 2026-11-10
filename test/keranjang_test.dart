import 'package:flutter_test/flutter_test.dart';
import 'package:pm_pertemuan_07_4243250056/data.dart';
import 'package:pm_pertemuan_07_4243250056/keranjang_model.dart';

void main() {
  test('tambah: jumlah dan total serta notifikasi', () {
    final k = KeranjangModel();
    var n = 0;
    k.addListener(() => n++);
    k.tambah(daftarProduk[0]);
    k.tambah(daftarProduk[0]);
    k.tambah(daftarProduk[1]);
    expect(k.jumlahItem, 3);
    expect(k.total, 170000);
    expect(n, 3);
    k.dispose();
  });
  test('kurangi hingga kosong', () {
    final k = KeranjangModel();
    k.tambah(daftarProduk[0]);
    k.kurangi(daftarProduk[0]);
    expect(k.item, isEmpty);
    k.dispose();
  });
  test('checkout simulasi mengosongkan isi', () {
    final k = KeranjangModel();
    k.tambah(daftarProduk[2]);
    k.kosongkan();
    expect(k.total, 0);
    k.dispose();
  });
}
