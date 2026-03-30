import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/view/widgets/app_navigation_bar.dart';
import '../cubit/main_cubit.dart';
import '../../../search/presentation/view/search_view.dart';
import '../../../profile/presentation/view/profile_view.dart';
import '../../../orders/presentation/view/orders_view.dart';
import 'home_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                IndexedStack(
                  index: state.currentIndex,
                  children: [
                    const HomeView(),
                    const SearchView(),
                    const OrdersView(),
                    const ProfileView(),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedSlide(
                    offset: state.isNavbarVisible
                        ? Offset.zero
                        : const Offset(0, 1),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: AnimatedOpacity(
                      opacity: state.isNavbarVisible ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Material(
                        elevation: 8,
                        color: Colors.white,
                        child: AppNavigationBar(
                          currentIndex: state.currentIndex,
                          onTap: (index) {
                            context.read<MainCubit>().changeIndex(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
