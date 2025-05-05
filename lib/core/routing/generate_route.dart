import 'package:flutter/material.dart';
import 'package:flutter_course/core/routing/app_routes.dart';
import 'package:flutter_course/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter_course/features/home/presentation/pages/home_pages.dart';
import 'package:flutter_course/features/checkout/presentation/pages/checkout_success_page.dart';
import 'package:flutter_course/features/login/presentation/pages/login.dart';
import 'package:flutter_course/features/order/presentation/pages/order_page.dart';
import 'package:flutter_course/features/register/presentation/pages/register.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return _fadeRoute(const HomePage());
    case AppRoutes.cart:
      return _fadeRoute(const CartPage());
    // case AppRoutes.product:
    //   return _fadeRoute(ProductListPage());
  
  case AppRoutes.order: // ✅ tambahkan route ini
      return _fadeRoute(const OrderPage());
    case AppRoutes.checkoutSuccess:
      return _fadeRoute(const CheckoutSuccessPage());
    case AppRoutes.register:
      return _fadeRoute(const RegisterPage());
    case AppRoutes.login:
      return _fadeRoute(const LoginPage());
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('Coming Soon')),
        ),
      );
  }
}


// Custom Fade Transition Route
PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}
