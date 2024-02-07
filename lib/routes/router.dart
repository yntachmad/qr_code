import 'package:go_router/go_router.dart';
import 'package:qr_code/pages/detail_product.dart';
import 'package:qr_code/pages/home_page.dart';
import 'package:qr_code/pages/product_page.dart';

import '../pages/error_page.dart';
import '../pages/setting_page.dart';

// GoRouter configuration
final router = GoRouter(
  errorBuilder: (context, state) => const ErrorPage(),
// 1 Level = push replacements
// sub level = push biasa (ada tombol back)
//prioritas ke sub level (dari atas ke bawah)

  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage(), routes: [
      GoRoute(
          path: 'product',
          builder: (context, state) => const ProductPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => const DetailProductPage(),
            ),
          ]),
      GoRoute(
        path: 'setting',
        builder: (context, state) => const SettingPage(),
      ),
    ]),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingPage(),
    ),
    GoRoute(
      path: '/settingsss',
      builder: (context, state) => const SettingPage(),
    ),
  ],
);
