import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code/pages/add_product_page.dart';
import 'package:qr_code/pages/detail_product.dart';
import 'package:qr_code/pages/home_page.dart';
import 'package:qr_code/pages/product_page.dart';

// import '../models/product.dart';
import '../models/product.dart';
import '../pages/error_page.dart';
import '../pages/login_page.dart';

part 'route_name.dart';

// GoRouter configuration
final router = GoRouter(
  redirect: (context, state) {
    //Cek Status auth, apakah sdh login / tidak
    FirebaseAuth auth = FirebaseAuth.instance;
    // print(auth.currentUser);
    if (auth.currentUser == null) {
      //tidak sedang login / tidak ada user yg aktif saat ini
      return '/login';
    } else {
      return null;
    }
  },
  errorBuilder: (context, state) => const ErrorPage(),
// 1 Level = push replacements
// sub level = push biasa (ada tombol back)
//prioritas ke sub level (dari atas ke bawah)

  routes: [
    GoRoute(
      path: '/',
      name: Routers.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'product',
          name: Routers.product,
          builder: (context, state) => const ProductPage(),
          routes: [
            GoRoute(
              path: ':productId',
              name: Routers.detailProduct,
              builder: (context, state) {
                final id = state.pathParameters['productId'].toString();
                final dataProduct = state.extra as Product;
                return DetailProductPage(productId: id, data: dataProduct);
              },

              // }, => DetailProductPage(
              //   // state.pathParameters['productId'].toString(),

              //   // state.params['productId'].toString(),
              //   // state.extra as Product,
              // ),
            ),
          ],
        ),
        GoRoute(
          path: 'addProduct',
          name: Routers.addProduct,
          builder: (context, state) => AddProductPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      name: Routers.login,
      builder: (context, state) => LoginPage(),
    ),
  ],
);
