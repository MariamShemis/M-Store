import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';

class ProfileStatisticCard extends StatelessWidget {
  const ProfileStatisticCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: REdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ColorManager.primaryColor, size: 28.sp),
          const Spacer(),
          Text(value, style: textTheme.titleMedium),
          SizedBox(height: 4.h),
          Text(title.toUpperCase(), style: textTheme.bodySmall),
        ],
      ),
    );
  }
}