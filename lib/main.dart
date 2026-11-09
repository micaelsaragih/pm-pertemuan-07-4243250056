import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'halaman_detail.dart';
import 'halaman_katalog.dart';
import 'halaman_kategori.dart';
import 'halaman_keranjang.dart';
import 'halaman_tentang.dart';
import 'keranjang_model.dart';

void main() => runApp(
  ChangeNotifierProvider(create: (_) => KeranjangModel(), child: const KatalogApp()),
);

final router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => KerangkaNavigasi(shell: shell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/', builder: (_, __) => const HalamanKatalog(), routes: [
            GoRoute(path: 'produk/:id', builder: (_, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              return HalamanDetail(produk: id == null ? null : cariProduk(id));
            }),
            GoRoute(path: 'kategori/:nama',
              builder: (_, state) => HalamanKategori(nama: state.pathParameters['nama'] ?? '')),
          ]),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/tentang', builder: (_, __) => const HalamanTentang()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/keranjang', builder: (_, __) => const HalamanKeranjang()),
        ]),
      ],
    ),
  ],
);

class KatalogApp extends StatelessWidget {
  const KatalogApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Oleh-Oleh Medan',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6D4C41)), useMaterial3: true),
    routerConfig: router,
  );
}

class KerangkaNavigasi extends StatelessWidget {
  const KerangkaNavigasi({super.key, required this.shell});
  final StatefulNavigationShell shell;

  void _pilih(int index) => shell.goBranch(index, initialLocation: index == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.sizeOf(context).width;
    final jumlah = context.select((KeranjangModel k) => k.jumlahItem);
    final iconKeranjang = Badge.count(
      count: jumlah,
      isLabelVisible: jumlah > 0,
      child: const Icon(Icons.shopping_cart_outlined),
    );
    if (lebar >= 840) {
      return Scaffold(body: Row(children: [
        NavigationRail(
          selectedIndex: shell.currentIndex, onDestinationSelected: _pilih,
          labelType: NavigationRailLabelType.all,
          destinations: [
            const NavigationRailDestination(icon: Icon(Icons.storefront_outlined), label: Text('Katalog')),
            const NavigationRailDestination(icon: Icon(Icons.info_outline), label: Text('Tentang')),
            NavigationRailDestination(icon: iconKeranjang, label: const Text('Keranjang')),
          ],
        ),
        const VerticalDivider(width: 1),
        Expanded(child: shell),
      ]));
    }
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex, onDestinationSelected: _pilih,
        destinations: [
          const NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'Katalog'),
          const NavigationDestination(icon: Icon(Icons.info_outline), label: 'Tentang'),
          NavigationDestination(icon: iconKeranjang, label: 'Keranjang'),
        ],
      ),
    );
  }
}
