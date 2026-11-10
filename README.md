# Praktikum 7 — State Management Flutter

**Micael Zecsen Saragih | 4243250056 | PSIK24D | Ilmu Komputer UNIMED**

Kelanjutan katalog oleh-oleh Pertemuan 6. Cabang `keranjang-provider` memakai `ChangeNotifierProvider`; cabang `keranjang-cubit` memakai `BlocProvider` dan state immutable. Branch `keranjang-cubit` berisi versi Cubit lengkap.

## Fitur
- Katalog enam produk, FilterChip, halaman kategori, Hero, detail responsif, halaman Tentang
- Navigasi adaptif (`NavigationBar` / `NavigationRail`) dengan tab Keranjang
- Badge jumlah item lintas halaman
- Tambah produk dari detail; ubah jumlah, subtotal, total, checkout simulasi dengan SnackBar
- Unit test logika keranjang

## Cara menjalankan

```powershell
flutter create --org id.ac.unimed --project-name pm_pertemuan_07_4243250056 .
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Gunakan `flutter create` hanya sekali untuk melengkapi folder platform yang belum tersedia. Lihat branch `keranjang-provider` dan `keranjang-cubit` untuk perbandingan. Foto produk pada versi lokal Pertemuan 6 yang sudah diperbarui belum disertakan dalam ZIP awal ini; ilustrasi ikon bawaan tetap dapat digunakan secara offline.

## Perbandingan pendekatan

| Aspek | Provider | Cubit |
|---|---|---|
| Logika | `KeranjangModel` (`ChangeNotifier`) | `KeranjangCubit` (`Cubit<KeranjangState>`) |
| Perubahan state | Mutasi map + `notifyListeners()` | Map baru + `emit()` |
| Rebuild UI | `watch`/`select` | `BlocBuilder`/`BlocSelector` |
| Pemanggilan aksi | `context.read<KeranjangModel>()` | `context.read<KeranjangCubit>()` |
| Pengujian | Unit test tanpa widget | Unit test tanpa widget; state immutable |
| Pilihan proyek | Cocok untuk skala kecil–menengah | Cocok ketika alur perubahan perlu lebih eksplisit |

## Atribusi Aset Foto

Foto produk pada aplikasi ini bersumber dari Wikimedia Commons untuk keperluan tugas akademik dan merupakan ilustrasi representatif generik (bukan foto resmi merek/kemasan produk). Seluruh kredit fotografer, lisensi (Creative Commons), tautan sumber, dan keterangan modifikasi terdokumentasi lengkap pada [docs/KREDIT_FOTO.md](docs/KREDIT_FOTO.md).

Dokumentasi screenshot dan verifikasi runtime ditambahkan setelah diuji di laptop. Penggunaan AI: AI membantu implementasi kode dan dokumentasi; pengujian aplikasi dan bukti pelaksanaan diperiksa pengguna.


**Cabang aktif:** `keranjang-cubit`; gunakan `flutter pub get` setelah berpindah branch. Checkout ditangani oleh `BlocConsumer` (listener untuk SnackBar).
