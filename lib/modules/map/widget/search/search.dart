import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:student_app/service/size_screen.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: SizeScreen.sizeSpace),
          child: TextField(
            controller: controller,
            textAlignVertical: TextAlignVertical.bottom,
            textInputAction: TextInputAction.go,
            style: AppTextStyles.h4.copyWith(color: Colors.black54),
            enableSuggestions: false,
            autocorrect: false,
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         // builder: ((context) => const PageSearch())));
            },
            decoration: InputDecoration(
                hintText: 'Tìm kiếm tại đây',
                hintStyle: AppTextStyles.h5.copyWith(color: Colors.black54),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    borderSide: BorderSide(color: Colors.white)),
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                hoverColor: Colors.white),
          ),
        ),
      ],
    );
  }
}
