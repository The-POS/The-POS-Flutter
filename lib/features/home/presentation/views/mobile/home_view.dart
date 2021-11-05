import 'package:flutter/material.dart';
import 'package:thepos/features/home/presentation/views/mobile/common/app_bar.dart';

import 'common/categories_widget.dart';
import 'common/products/products_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: POSAppBar(),
      body: Column(
        children: const <Widget>[
          CategoriesWidget(),
          Expanded(child: ProductsWidget())
        ],
      ),
    );
  }
}
