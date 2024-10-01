import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../auth/presentation/pages/components/textfield_sufiix.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool focus = false;
  bool hasText = false;
  final searchController = TextEditingController();
  onTapOutside(BuildContext context) {
    focus = false;
    FocusScope.of(context).unfocus();
  }

  onClear(BuildContext context) {
    searchController.text = '';
    hasText = false;
    onTapOutside(context);
  }

  onTapField() {
    focus = true;
  }

  checkText() {
    hasText = searchController.value.text.toString().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: focus
            ? const LinearGradient(colors: [
                Colors.purpleAccent,
                Colors.pink,
              ])
            : null,
      ),
      child: TextFormField(
        controller: searchController,
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
          suffixIcon: hasText
              ? GestureDetector(
                  onTap: () => onClear(context),
                  child: const TextFieldSufix(
                    icon: Icons.clear,
                  ),
                )
              : const SizedBox(),
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
