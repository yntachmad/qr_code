import 'package:go_router/go_router.dart';
import 'package:qr_code/pages/home_page.dart';
import 'package:qr_code/pages/product_page.dart';

import '../pages/error_page.dart';
import '../pages/setting_page.dart';

// GoRouter configuration
final router = GoRouter(
  errorBuilder: (context, state) => const ErrorPage(),
// 1 Level = push replacements
// sub level = push biasa (ada tombol back)
//prioritas

  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage(), routes: [
      GoRoute(
        path: 'product',
        builder: (context, state) => const ProductPage(),
      ),
    ]),
    GoRoute(
      path: '/setting',
      builder: (context, state) => const SettingPage(),
    ),
  ],
);
