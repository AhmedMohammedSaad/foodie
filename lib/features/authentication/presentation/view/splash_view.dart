import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 3));
    final session = Supabase.instance.client.auth.currentSession;
    if (mounted) {
      if (session != null) {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.onboarding);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 140.r,
                  height: 140.r,
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/app_logo.png'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.08),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              30.verticalSpace,
              Text(
                'Foodie',
                style: TextStyle(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  letterSpacing: 1.5,
                ),
              ),
              8.verticalSpace,
              Text(
                'Healthy • Delicious • Fast',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
              60.verticalSpace,
              SizedBox(
                width: 25.r,
                height: 25.r,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
