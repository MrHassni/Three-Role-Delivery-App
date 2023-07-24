import 'package:delivery_app/core/providers/brand_and_product_provider.dart';
import 'package:delivery_app/views/profile/profile.dart';
import 'package:delivery_app/views/search/search.dart';
import 'package:delivery_app/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/providers/page_provider.dart';
import 'base.dart';
import 'basket/basket.dart';
import 'home/home.dart';
import 'liked/liked.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    Provider.of<BrandAndProductProvider>(context, listen: false).getAllProducts(context: context);
    Provider.of<BrandAndProductProvider>(context, listen: false).getAllBrands(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, PageProvider page, Widget? child) {
      return Base(
        child: Stack(
          children: [
            pages[page.p],
            const Navbar(),
          ],
        ),
      );
    });
  }
}

List<Widget> pages = [
  const Home(),
  const Search(),
  const Basket(),
  // const Liked(),
  const Profile(),
];
