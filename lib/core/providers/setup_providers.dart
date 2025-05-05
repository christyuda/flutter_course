import 'package:flutter_course/core/providers/navigation_provider.dart';
import 'package:flutter_course/features/cart/presentation/provider/cart_provider.dart';
import 'package:flutter_course/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_course/features/login/presentation/providers/login_provider.dart';
import 'package:flutter_course/features/myuser/presentation/providers/user_provider.dart';
import 'package:flutter_course/features/order/presentation/providers/order_provider.dart';
import 'package:flutter_course/features/product/presentation/providers/product_provider.dart';
import 'package:flutter_course/features/register/presentation/providers/register_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildStatelessWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildStatelessWidget> independentServices = [
  ChangeNotifierProvider(create: (_) => HomeProvider()),
  // ChangeNotifierProvider(create: (_) => ProductProvider()),
  ChangeNotifierProvider(create: (_) => CartProvider()),
  ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => RegisterProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => OrderProvider()),


];

List<SingleChildStatelessWidget> dependentServices = [];

abstract class BaseProvider implements SingleChildStatelessWidget {}
