import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';

class UserImageProfile extends StatelessWidget {
  const UserImageProfile({super.key, required this.image, this.onTap});
  final Widget image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            padding: REdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorManager.primaryColor.withOpacity(0.3),
                width: 3,
              ),
            ),
            child: image,
          ),
          Positioned(
            right: -1,
            bottom: 1,
            child: CircleAvatar(
              radius: 15.r,
              backgroundColor: ColorManager.primaryColor,
              child: Icon(
                Icons.camera_alt,
                color: ColorManager.white,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
