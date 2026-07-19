import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/main_layout/home/data/cubit/home_cubit.dart';
import 'package:m_store_1/feature/main_layout/home/data/cubit/home_state.dart';
import 'package:m_store_1/feature/main_layout/home/presentation/widgets/category_statistics.dart';
import 'package:m_store_1/feature/main_layout/home/presentation/widgets/home_statistics.dart';

import '../widgets/home_header.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        final cubit = context.read<HomeCubit>();
        final home = cubit.homeModel!;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: REdgeInsets.all(16),
              child: Column(
                children: [
                  HomeHeader(
                    name: home.userName,
                    image: CircleAvatar(
                      radius: 26.r,
                      backgroundColor: ColorManager.primaryColor20,
                      backgroundImage:
                          home.userImage != null && home.userImage!.isNotEmpty
                          ? NetworkImage(home.userImage!)
                          : null,
                      child: home.userImage == null || home.userImage!.isEmpty
                          ? Icon(Icons.person, color: ColorManager.primaryColor)
                          : null,
                    ),
                    onPressedNotification: () {},
                  ),
                  SizedBox(height: 3.h),
                  Divider(
                    color: ColorManager.greyDark.withOpacity(.2),
                    thickness: 1.5,
                    indent: 4,
                    endIndent: 4,
                  ),
                  SizedBox(height: 20.h),
                  HomeStatistics(dashboard: home.dashboard),
                  SizedBox(height: 24.h),
                  CategoryStatistics(categories: home.topCategories),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
