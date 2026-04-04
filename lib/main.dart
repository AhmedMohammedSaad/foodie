import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_colors.dart';
import 'core/router/app_router.dart';
import 'core/router/routes.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/utils/app_constants.dart';
import 'core/di/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );
  await initDI();
  runApp(FoodApp(appRouter: AppRouter()));
}

class FoodApp extends StatelessWidget {
  final AppRouter appRouter;
  const FoodApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CartCubit>()),
          ],
          child: MaterialApp(
            title: 'Food Delivery App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: AppColors.primary,
              scaffoldBackgroundColor: AppColors.background,
              fontFamily: 'Poppins',
            ),
            onGenerateRoute: appRouter.generateRoute,
            initialRoute: Routes.splash,
          ),
        );
      },
    );
  }
}
