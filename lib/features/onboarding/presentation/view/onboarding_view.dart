import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/onboarding_model.dart';
import '../cubit/onboarding_cubit.dart';
import '../widgets/onboarding_page_item.dart';
import '../widgets/onboarding_nav_bar.dart';
import '../../../../core/router/routes.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;
  final List<OnboardingModel> _pages = [
    OnboardingModel(
      image: 'assets/images/onboarding_1.png',
      title: 'Fastest Food Delivery',
      description:
          'Get your favorite meals delivered to your doorstep in record time.',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_2.png',
      title: 'Diverse Cuisines',
      description:
          'Explore a wide variety of cuisines from the best restaurants around you.',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_3.png',
      title: 'Easy Tracking',
      description:
          'Track your order in real-time from the kitchen to your home.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, state) {
                    return PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        context.read<OnboardingCubit>().updatePage(index);
                      },
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        return OnboardingPageItem(model: _pages[index]);
                      },
                    );
                  },
                ),
              ),
              BlocConsumer<OnboardingCubit, OnboardingState>(
                listener: (context, state) {
                  if (state is OnboardingCompleted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.login,
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  final cubit = context.read<OnboardingCubit>();
                  return OnboardingNavBar(
                    pageController: _pageController,
                    currentPage: cubit.currentPage,
                    totalPages: _pages.length,
                    onNext: () {
                      if (cubit.currentPage < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        cubit.completeOnboarding();
                      }
                    },
                    onSkip: () {
                      _pageController.animateToPage(
                        _pages.length - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
