import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_arch_utils/flutter_arch_utils.dart';
import 'package:flutter_image_loading/controllers/home_screen_controller.dart';
import 'package:flutter_image_loading/models/image_response_models.dart';
import 'package:flutter_image_loading/views/homeScreen/widgets/search_bar_widget.dart';
import 'package:flutter_image_loading/views/imageScreen/image_screen.dart';
import 'package:flutter_image_loading/views/widgets/custom_app_bar.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _usableHeight = 0;
  double _usableWidth = 0;
  late ScrollController scrollController;
  HomeScreenController controller = Get.find();

  String searchTerm = "";

  @override
  void initState() {
    scrollController = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (scrollController.position.extentAfter <= 0) {
        controller.getMoreImages(searchTerm);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ResponsiveSafeArea(
        builder: (context, size) {
          _usableWidth = size.width;
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
                  CustomAppBar(showBackIcon: false),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.vdp(), horizontal: 16.hdp()),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SearchBarWidget(
                            onSearchButtonClicked: (s) {
                              debugPrint("CLICKED");
                              if(searchTerm!=s){
                                controller.clearImageList();
                              }
                              searchTerm = s;
                              controller.getMoreImages(s);
                            },
                          ),
                          // Expanded(child: Container()),
                          VSpace(16),
                          Expanded(
                            child: Obx(
                              () => ListView.builder(
                                controller: scrollController,
                                scrollDirection: Axis.vertical,
                                itemCount: controller.imageList.length,
                                itemBuilder: (context, index) {
                                  final imageHit = controller.imageList[index];
                                  if (imageHit is ImageHits) {
                                    double imageAspectRatio = imageHit.imageWidth / (imageHit.imageHeight).toDouble();
                                    final imageHeight = (_usableWidth - 32.hdp()) / imageAspectRatio;
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) => ImageScreen(imageUrl: imageHit.largeImageURL),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 4.vdp()),
                                        child: CachedNetworkImage(
                                          imageUrl: imageHit.largeImageURL,
                                          height: imageHeight,
                                          fit: BoxFit.fill,
                                          placeholder: (widget, text) {
                                            return Container(color: Colors.grey);
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.vdp()),
                                    child: Center(child: const CircularProgressIndicator()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
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
