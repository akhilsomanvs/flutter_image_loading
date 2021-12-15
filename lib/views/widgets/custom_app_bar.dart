import 'package:flutter/material.dart';
import 'package:flutter_arch_utils/flutter_arch_utils.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key, this.showBackIcon = true}) : super(key: key);
  bool showBackIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.vdp(),
      color: Colors.blueAccent,
      child: Row(
        children: [
          Opacity(
            opacity: showBackIcon ? 1.0 : 0.0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.vdp(),
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Image Loading",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.sp(), color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Opacity(
            opacity: 0.0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                size: 24.vdp(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
