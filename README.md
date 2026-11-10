# Praktikum 7 — Keranjang Belanja dengan Provider dan Cubit

**Micael Zecsen Saragih — 4243250056 — PSIK24D — Ilmu Komputer UNIMED**

Project melanjutkan Katalog Oleh-Oleh Medan Pertemuan 6. Versi ini memakai Provider. Di GitHub tersedia branch `keranjang-provider` dan `keranjang-cubit` untuk membandingkan implementasi.

## Fitur

- Katalog 6 produk dan FilterChip kategori; grid responsif 2/3/4 kolom.
- Routing halaman produk, kategori, Tentang, Keranjang via go_router.
- Tambah produk dari detail, badge jumlah item di navigasi, +/−, subtotal, total, checkout simulasi dengan SnackBar.
- NavigationBar di layar sempit dan NavigationRail di layar lebar.
- Unit test model keranjang dan widget test katalog.

## Menjalankan

```powershell
flutter create --org id.ac.unimed --project-name pm_pertemuan_07_4243250056 .
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Perintah `flutter create` dipakai sekali untuk melengkapi berkas platform. Gambar produk pada ZIP ini memakai ikon offline; foto produk dari versi lokal Pertemuan 6 dapat ditambahkan secara terpisah. Dokumentasi akhir akan diperbarui setelah screenshot tersedia.

## Perbandingan

| Aspek | Provider | Cubit |
|---|---|---|
| Penyimpanan | ChangeNotifier mutable | KeranjangState immutable |
| Notifikasi | notifyListeners | emit |
| UI | watch, read, select | BlocBuilder/BlocConsumer, read, select |
| Test | Unit test model | Unit test Cubit |

## Atribusi Aset Foto

Foto produk pada aplikasi ini bersumber dari Wikimedia Commons untuk keperluan tugas akademik dan merupakan ilustrasi representatif generik (bukan foto resmi merek/kemasan produk). Seluruh kredit fotografer, lisensi (Creative Commons), tautan sumber, dan keterangan modifikasi terdokumentasi lengkap pada [docs/KREDIT_FOTO.md](docs/KREDIT_FOTO.md).

AI digunakan untuk membantu penyusunan kode dan dokumentasi. Pengujian runtime dan screenshot menjadi tanggung jawab mahasiswa.
