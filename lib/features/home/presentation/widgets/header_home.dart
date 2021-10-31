import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/home/controllers/home_controller.dart';
import 'package:thepos/features/home/presentation/widgets/search_widget.dart';

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title:SearchBar(isSearching: controller.searching.value,controller:controller),
        leading: InkWell(
          onTap: () {
            controller.showHidCart();
          },
          child: Container(
            color: Color(0xffF79624),
            width: 50,
            child: Icon(Icons.menu),
          ),
        ),
        actions: controller.searching.value?[
        InkWell(
          onTap: (){
            controller.showSearch();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
        ),
        ]:[
          Icon(
            Icons.qr_code,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: (){
              controller.showSearch();
            },
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final bool isSearching;
  final HomeController controller;

  SearchBar({required this.isSearching,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimateExpansion(
          animate: !isSearching,
          axisAlignment: 1.0,
          child: Text("المبيعات",
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              )),
        ),
        AnimateExpansion(
          animate: isSearching,
          axisAlignment: -1.0,
          child: Search(controller),
        ),
      ],
    );
  }
}

