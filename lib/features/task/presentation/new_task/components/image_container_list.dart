import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_images.dart';
import 'image_container.dart';

class ImageContainerList extends StatefulWidget {
  const ImageContainerList({super.key});

  @override
  State<ImageContainerList> createState() => _ImageContainerListState();
}

class _ImageContainerListState extends State<ImageContainerList> {
    RxInt selectedImageIndex = 1.obs;
  setImage(int index) {
    selectedImageIndex.value = index;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => ImageContainer(
          onTap: ()=>setImage(1),
          image: AppImage.back2, focus: selectedImageIndex.value==1,
        ),),
        Obx(() => ImageContainer(
          focus: selectedImageIndex.value==2,
          onTap: ()=>setImage(2),
          image: AppImage.back3,
        ),),
        Obx(() => ImageContainer(
          focus: selectedImageIndex.value==3,
          onTap: ()=>setImage(3),
          image: AppImage.back1,
        ),),
      ],
    );
  }
}
