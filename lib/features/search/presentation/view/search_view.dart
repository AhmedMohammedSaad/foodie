import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/search_cubit.dart';
import '../widgets/search_input_section.dart';
import '../widgets/search_results_section.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchCubit>(),
      child: const SearchViewBody(),
    );
  }
}

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Search',
          style: AppTextStyle.font24SemiBold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              const SearchInputSection(),
              SizedBox(height: 24.h),
              Text(
                'Results',
                style: AppTextStyle.font18SemiBold,
              ),
              const SearchResultsSection(),
              SizedBox(height: 100.h), // Padding for the bottom nav bar
            ],
          ),
        ),
      ),
    );
  }
}
