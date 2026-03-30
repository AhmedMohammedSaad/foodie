import 'package:flutter/material.dart';
import 'package:app_food/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:app_food/features/authentication/presentation/view/login_view.dart';
import 'package:app_food/features/authentication/presentation/view/signup_view.dart';
import 'package:app_food/features/authentication/presentation/view/forgot_password_view.dart';
import 'package:app_food/features/authentication/presentation/view/otp_view.dart';
import 'package:app_food/features/home/presentation/view/main_view.dart';
import 'package:app_food/features/restaurant/presentation/view/restaurant_details_view.dart';
import 'package:app_food/features/restaurant/presentation/view/product_details_view.dart';
import 'package:app_food/features/restaurant/domain/entities/menu_item_entity.dart';
import 'package:app_food/features/category/presentation/view/category_view.dart';
import 'package:app_food/features/orders/presentation/view/track_order_view.dart';
import 'package:app_food/features/authentication/presentation/view/splash_view.dart';
import 'package:app_food/features/authentication/domain/repositories/auth_repository.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignupView());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.otp:
        final args = settings.arguments as Map<String, dynamic>;
        final email = args['email'] as String;
        final type = args['type'] as AuthOtpType;
        return MaterialPageRoute(
          builder: (_) => OtpView(email: email, type: type),
        );
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.restaurantDetails:
        final restaurantId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => RestaurantDetailsView(restaurantId: restaurantId),
        );
      case Routes.productDetails:
        final item = settings.arguments as MenuItemEntity;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsView(item: item),
        );
      case Routes.category:
        return MaterialPageRoute(builder: (_) => const CategoryView());
      case Routes.trackOrder:
        final orderId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => TrackOrderView(orderId: orderId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
