import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.name,
    required this.image,
    required this.onPressedNotification,
  });

  final String name;
  final Widget image;
  final VoidCallback onPressedNotification;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          padding: REdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorManager.brownDark.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: image,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${appLocalizations.welcome_back} ✨", style: textTheme.bodySmall),
              SizedBox(height: 4.h),
              Text(name, style: textTheme.titleMedium),
            ],
          ),
        ),
        Container(
          width: 46.w,
          height: 46.h,
          decoration: BoxDecoration(
            color: Colors.white,
            //borderRadius: BorderRadius.circular(14.r),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressedNotification,
            icon: Icon(
              Icons.notifications_none_rounded,
              color: ColorManager.primaryColor,
              size: 25.sp,
            ),
          ),
        ),
      ],
    );
  }
}
