import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/rendering.dart';
import '../cubit/home_cubit.dart';
import '../widgets/home_header_section.dart';
import '../widgets/home_search_section.dart';
import '../widgets/home_categories_section.dart';
import '../widgets/home_popular_section.dart';
import '../cubit/main_cubit.dart';
import '../../../../core/di/injection.dart';
import '../cubit/home_state.dart';
import 'home_error_view.dart';
import 'home_loading_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      context.read<MainCubit>().setNavbarVisibility(false);
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      context.read<MainCubit>().setNavbarVisibility(true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getHomeData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const HomeLoadingView();
              } else if (state is HomeError) {
                return HomeErrorView(
                  message: state.message,
                  onRetry: () => context.read<HomeCubit>().getHomeData(),
                );
              } else if (state is HomeSuccess) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      pinned: false,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      flexibleSpace: const FlexibleSpaceBar(
                        background: HomeHeaderSection(),
                        collapseMode: CollapseMode.pin,
                      ),
                      expandedHeight: 80.h,
                    ),
                    const SliverToBoxAdapter(child: HomeSearchSection()),
                    const SliverToBoxAdapter(child: HomeCategoriesSection()),
                    const SliverToBoxAdapter(child: HomePopularSection()),
                    SliverPadding(padding: EdgeInsets.only(bottom: 100.h)),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

