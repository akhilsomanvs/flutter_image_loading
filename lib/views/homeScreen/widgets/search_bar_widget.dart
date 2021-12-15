import 'package:flutter/material.dart';
import 'package:flutter_arch_utils/flutter_arch_utils.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({Key? key, required this.onSearchButtonClicked}) : super(key: key);

  Function(String) onSearchButtonClicked;

  final TextStyle _textStyle = TextStyle(fontSize: 12.sp());
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.hdp(), vertical: 2.vdp()),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              style: _textStyle,
              decoration: InputDecoration(
                hintStyle: _textStyle.copyWith(color: Colors.grey),
                hintText: "Type Here",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
          HSpace(8),
          OutlinedButton(
            onPressed: () {
              String searchTerm = _textEditingController.text;
              if (searchTerm.trim().isNotEmpty) {
                onSearchButtonClicked(searchTerm.trim());
              }
            },
            style: OutlinedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              "Search",
              style: _textStyle.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
