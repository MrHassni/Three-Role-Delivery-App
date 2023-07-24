import 'package:delivery_app/core/providers/brand_and_product_provider.dart';
import 'package:delivery_app/core/providers/cart_provider.dart';
import 'package:delivery_app/core/providers/order_provider.dart';
import 'package:delivery_app/core/providers/page_provider.dart';
import 'package:delivery_app/core/providers/setting_page_provider.dart';
import 'package:delivery_app/core/providers/users_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'auth_providers.dart';
import 'onboard_providers.dart';
import 'theme_provider.dart';

class AppProviders {
  static AppProviders? _instance;

  static AppProviders? get instance {
    _instance ??= AppProviders._init();
    return _instance;
  }

  AppProviders._init();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => OnboardProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => SettingPageProvider(),),
    ChangeNotifierProvider(
      create: (context) => CartProvider()),
    ChangeNotifierProvider(
      create: (context) => OrderProvider()),
    ChangeNotifierProvider(
      create: (context) => UsersProvider()),
    ChangeNotifierProvider(
      create: (context) => BrandAndProductProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ];
}
