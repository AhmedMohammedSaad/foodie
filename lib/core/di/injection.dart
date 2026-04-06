import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/restaurant/domain/repositories/restaurant_repository.dart';
import '../../features/restaurant/domain/usecases/get_restaurant_details_usecase.dart';
import '../../features/restaurant/domain/usecases/toggle_restaurant_favorite_usecase.dart';
import '../../features/restaurant/presentation/cubit/restaurant_cubit.dart';
import '../../features/restaurant/data/repositories/restaurant_repository_impl.dart';
import '../../features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/usecases/get_home_data_usecase.dart';
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/cart/data/datasources/cart_remote_data_source.dart';
import '../../features/cart/data/datasources/cart_remote_data_source_impl.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/usecases/get_cart_items_usecase.dart';
import '../../features/cart/domain/usecases/add_to_cart_usecase.dart';
import '../../features/cart/domain/usecases/remove_from_cart_usecase.dart';
import '../../features/cart/domain/usecases/clear_cart_usecase.dart';
// Auth Imports
import '../../features/authentication/data/datasources/auth_remote_data_source.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/authentication/domain/usecases/login_usecase.dart';
import '../../features/authentication/domain/usecases/signup_usecase.dart';
import '../../features/authentication/domain/usecases/forgot_password_usecase.dart';
import '../../features/authentication/domain/usecases/verify_otp_usecase.dart';
import '../../features/authentication/domain/usecases/check_session_usecase.dart';
import '../../features/authentication/presentation/cubit/auth_cubit.dart';

// Profile Imports
import '../../features/profile/presentation/cubit/profile_cubit.dart';

// Orders Imports
import '../../features/orders/data/datasources/orders_remote_data_source.dart';
import '../../features/orders/data/repositories/orders_repository_impl.dart';
import '../../features/orders/domain/repositories/orders_repository.dart';
import '../../features/orders/domain/usecases/get_orders_usecase.dart';
import '../../features/orders/presentation/cubit/orders_cubit.dart';

// Search Imports
import '../../features/search/data/datasources/search_remote_data_source.dart';
import '../../features/search/data/repositories/search_repository_impl.dart';
import '../../features/search/domain/repositories/search_repository.dart';
import '../../features/search/domain/usecases/search_use_case.dart';
import '../../features/search/presentation/cubit/search_cubit.dart';

final sl = GetIt.instance; // sl: Service Locator

Future<void> initDI() async {
  // Supabase
  sl.registerLazySingleton(() => Supabase.instance.client);

  // Features - Restaurant
  // Data Sources
  sl.registerLazySingleton<RestaurantRemoteDataSource>(() => RestaurantRemoteDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<RestaurantRepository>(() => RestaurantRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetRestaurantDetailsUseCase(sl()));
  sl.registerLazySingleton(() => ToggleRestaurantFavoriteUseCase(sl()));

  // Features - Home
  // Repository
  // Data Sources
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  
  // UseCases
  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));

  // Features - Auth
  // DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => CheckSessionUseCase(sl()));

  // Features - Cart
  // Data Sources
  sl.registerLazySingleton<CartRemoteDataSource>(() => CartRemoteDataSourceImpl(supabase: sl()));

  // Repository
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(remoteDataSource: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetCartItemsUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));

  // Cubits
  sl.registerLazySingleton(() => CartCubit(
    getCartItemsUseCase: sl(),
    addToCartUseCase: sl(),
    removeFromCartUseCase: sl(),
    clearCartUseCase: sl(),
  ));

  sl.registerFactory(() => AuthCubit(
    loginUseCase: sl(),
    signupUseCase: sl(),
    forgotPasswordUseCase: sl(),
    verifyOtpUseCase: sl(),
    checkSessionUseCase: sl(),
  ));

  // Features - Orders
  sl.registerLazySingleton<OrdersRemoteDataSource>(() => OrdersRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetOrdersUseCase(sl()));

  sl.registerFactory(() => OrdersCubit(sl()));

  sl.registerFactory(() => HomeCubit(sl(), sl()));

  sl.registerFactory(() => RestaurantCubit(sl(), sl()));

  sl.registerFactory(() => ProfileCubit(sl(), sl()));

  // Features - Search
  sl.registerLazySingleton<SearchRemoteDataSource>(() => SearchRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(sl()));
  sl.registerLazySingleton(() => SearchUseCase(sl()));
  sl.registerFactory(() => SearchCubit(sl()));
}
