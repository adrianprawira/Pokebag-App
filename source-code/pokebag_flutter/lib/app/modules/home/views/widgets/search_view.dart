import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pokebag_flutter/app/modules/home/controllers/home_controller.dart';

class SearchPokemon extends GetView<HomeController> {
  final homeC = Get.find<HomeController>();

  final String text;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  SearchPokemon({
    Key? key,
    required this.text,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.only(
            top: 15.h,
            left: 15.w,
            right: 15.w,
          ),
          shape: RoundedRectangleBorder(
              // side: BorderSide(
              //   width: 2,
              //   // color: ColorConst.defaultColor,
              // ),
              borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            leading: const Icon(Icons.search),
            title: TextField(
              controller: homeC.searchController,
              onChanged: onChanged,
              readOnly: readOnly,
              decoration: const InputDecoration(
                hintText: 'Search Pokemon',
                border: InputBorder.none,
              ),
            ),
            trailing: text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      homeC.searchController.clear();
                      onChanged!('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey.withOpacity(.7),
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
