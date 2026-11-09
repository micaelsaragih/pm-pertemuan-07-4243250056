import 'package:flutter_test/flutter_test.dart';
import 'package:pm_pertemuan_07_4243250056/data.dart';
import 'package:pm_pertemuan_07_4243250056/keranjang_cubit.dart';

void main() {
  test('tambah memperbarui jumlah dan total tanpa mutasi state lama', () async {
    final cubit = KeranjangCubit();
    final awal = cubit.state;
    cubit.tambah(daftarProduk[0]);
    cubit.tambah(daftarProduk[0]);
    cubit.tambah(daftarProduk[1]);
    expect(cubit.state.jumlahItem, 3);
    expect(cubit.state.total, 170000);
    expect(awal.jumlahItem, 0);
    await cubit.close();
  });
  test('kurangi sampai kosong menghapus entry keranjang', () async {
    final cubit = KeranjangCubit();
    cubit.tambah(daftarProduk[0]);
    cubit.tambah(daftarProduk[0]);
    cubit.kurangi(daftarProduk[0]);
    expect(cubit.state.jumlahDari(1), 1);
    cubit.kurangi(daftarProduk[0]);
    expect(cubit.state.item, isEmpty);
    await cubit.close();
  });
  test('checkout mengosongkan keranjang dan mencatat revisi', () async {
    final cubit = KeranjangCubit();
    cubit.tambah(daftarProduk[2]);
    cubit.checkout();
    expect(cubit.state.total, 0);
    expect(cubit.state.checkoutRevision, 1);
    await cubit.close();
  });
}
