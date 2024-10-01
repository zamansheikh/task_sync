import 'package:flutter/material.dart';

import '../../../../../core/constants/app_images.dart';
import 'image_container.dart';

class ImageContainerList extends StatefulWidget {
  const ImageContainerList({super.key});

  @override
  State<ImageContainerList> createState() => _ImageContainerListState();
}

class _ImageContainerListState extends State<ImageContainerList> {
  int selectedImageIndex = 1;
  setImage(int index) {
    selectedImageIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageContainer(
          onTap: () => setImage(1),
          image: AppImage.back2,
          focus: selectedImageIndex == 1,
        ),
        ImageContainer(
          focus: selectedImageIndex == 2,
          onTap: () => setImage(2),
          image: AppImage.back3,
        ),
        ImageContainer(
          focus: selectedImageIndex == 3,
          onTap: () => setImage(3),
          image: AppImage.back1,
        )
      ],
    );
  }
}
