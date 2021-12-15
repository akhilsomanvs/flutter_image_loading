import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch_utils/flutter_arch_utils.dart';
import 'package:flutter_image_loading/views/widgets/custom_app_bar.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({Key? key, required this.imageUrl}) : super(key: key);
  String imageUrl;
  double _usableHeight = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: ResponsiveSafeArea(
        builder: (context, size) {
          if (_usableHeight < size.height) {
            _usableHeight = size.height;
          }
          return SizedBox(
            height: _usableHeight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(),
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, text) => Container(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
