import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/home/presentation/widgets/category_statistics.dart';
import 'package:m_store_1/feature/main_layout/home/presentation/widgets/home_statistics.dart';
import 'package:m_store_1/feature/main_layout/home/presentation/widgets/revenue_profit_card.dart';

import '../widgets/home_header.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.all(16),
            child: Column(
              children: [
                HomeHeader(
                  name: 'Julianne Moretti',
                  image: CircleAvatar(
                    radius: 26.r,
                    backgroundColor: ColorManager.primaryColor,
                    child: Icon(Icons.person , color: ColorManager.white,),
                  ),
                  onPressedNotification: () {},
                ),
                SizedBox(height: 3.h),
                Divider(
                  color: ColorManager.greyDark.withOpacity(.2),
                  thickness: 1,
                  indent: 4,
                  endIndent: 4,
                ),
                SizedBox(height: 20.h),
                HomeStatistics(),
                SizedBox(height: 24.h),
                CategoryStatistics(),
                SizedBox(height: 24.h),
                RevenueProfitCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
