import 'package:flutter/material.dart';
import 'package:flutter_course/core/providers/setup_providers.dart';
import 'package:flutter_course/core/routing/generate_route.dart';
import 'package:flutter_course/core/utils/size_config.dart';
import 'package:flutter_course/features/product/presentation/domain/adapter/product_entity_adapter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  Hive.registerAdapter(ProductEntityAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers, // dari providers.dart
      child: LayoutBuilder(
        builder: (context, constraints) {
          SizeConfig().init(context); // Size Config Init
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-Commerce Web',
            onGenerateRoute: generateRoute, // pakai dynamic route
            initialRoute: 'HomePage',
          );
        },
      ),
    );
  }
}
