import 'package:flutter/material.dart';
import 'package:thepos/features/home/presentation/views/mobile/common/app_bar.dart';

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
      body: Container(),
    );
  }
}
