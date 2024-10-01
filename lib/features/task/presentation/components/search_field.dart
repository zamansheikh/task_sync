import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../auth/presentation/sign_up/components/textfield_sufiix.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  RxBool focus = false.obs;
  RxBool hasText = false.obs;
  final searchController = TextEditingController().obs;
  onTapOutside(BuildContext context) {
    focus.value = false;
    FocusScope.of(context).unfocus();
  }

  onClear(BuildContext context) {
    searchController.value.text = '';
    hasText.value = false;
    onTapOutside(context);
  }

  onTapField() {
    focus.value = true;
  }

  checkText() {
    hasText.value = searchController.value.text.toString().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: focus.value
            ? const LinearGradient(colors: [
                Colors.purpleAccent,
                Colors.pink,
              ])
            : null,
      ),
      child: TextFormField(
        controller: searchController.value,
        onTap: onTapField,
        onTapOutside: (event) {
          onTapOutside(context);
        },
        onChanged: (value) {
          checkText();
        },
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          filled: true,
          prefixIcon: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            // ignore: deprecated_member_use
            child: SvgPicture.asset(
              AppIcon.search,
              height: 20,
              width: 20,
              color: Colors.grey,
            ),
          ),
          suffixIcon: Obx(() => hasText.value
              ? GestureDetector(
                  onTap: () => onClear(context),
                  child: const TextFieldSufix(
                    icon: Icons.clear,
                  ),
                )
              : const SizedBox()),
          fillColor: primaryColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          hoverColor: Colors.pinkAccent,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          hintText: 'Search ...',
          hintStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 12),
        ),
      ),
    );
  }
}
