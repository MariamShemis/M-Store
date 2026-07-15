import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/assets_manager.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _dotsController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _logoSlide;

  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
    _logoScale = Tween<double>(
      begin: 0.6,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.elasticOut,
      ),
    );
    _logoOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_logoController);
    _logoSlide = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(begin: Offset.zero, end: const Offset(.03, 0)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(.03, 0),
          end: const Offset(-.03, 0),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: const Offset(-.03, 0),
          end: Offset.zero,
        ),
        weight: 1,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(.6, 1),
      ),
    );
    _textOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_textController);
    _textSlide = Tween<Offset>(
      begin: const Offset(0, .4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeOut,
      ),
    );
    _startAnimation();
  }

  Future<void> _startAnimation() async {
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 700));
    _textController.forward();
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              FadeTransition(
                opacity: _logoOpacity,
                child: SlideTransition(
                  position: _logoSlide,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Container(
                      width: 230.w,
                      height: 230.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: REdgeInsets.all(3),
                        child: Image.asset(
                          ImageAssets.logoApp,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              FadeTransition(
                opacity: _textOpacity,
                child: SlideTransition(
                  position: _textSlide,
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          ColorManager.blackText,
                          ColorManager.primaryColor,
                          ColorManager.blackText,
                        ],
                      ).createShader(bounds);
                    },
                    child: Text(
                      "M STORE",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.white,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35.h),
              AnimatedBuilder(
                animation: _dotsController,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dot(0),
                      SizedBox(width: 10.w),
                      _dot(1),
                      SizedBox(width: 10.w),
                      _dot(2),
                    ],
                  );
                },
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot(int index) {
    double value = (_dotsController.value * 3) - index;
    value = value.clamp(0.0, 1.0);
    final size = 8 + (6 * value);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: value > 0.5
            ? ColorManager.primaryColor
            : ColorManager.blackText,
        shape: BoxShape.circle,
      ),
    );
  }
}