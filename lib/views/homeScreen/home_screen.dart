import 'package:flutter/material.dart';
import 'package:flutter_arch_utils/flutter_arch_utils.dart';
import 'package:flutter_image_loading/controllers/home_screen_controller.dart';
import 'package:flutter_image_loading/views/homeScreen/widgets/search_bar_widget.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _usableHeight = 0;

  HomeScreenController controller = Get.find();

  @override
  void initState() {
    // controller.getMoreImages("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ResponsiveSafeArea(
        builder: (context, size) {
          if (_usableHeight < size.height) {
            _usableHeight = size.height;
          }
          return SingleChildScrollView(
            child: SizedBox(
              height: _usableHeight,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SearchBarWidget(
                    onSearchButtonClicked: (s) {
                      debugPrint("CLICKED");
                      controller.getMoreImages(s);
                    },
                  ),
                  // Expanded(child: Container()),
                  Expanded(
                    child: Obx(
                      () => LazyLoadScrollView(
                        onEndOfPage: () => controller.getMoreImages(""),
                        child: ListView.builder(
                          itemCount: controller.imageList.length,
                          itemBuilder: (context, index) {
                            return Text(controller.imageList[index].largeImageURL);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
