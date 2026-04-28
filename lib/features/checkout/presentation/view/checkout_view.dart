import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../cubit/checkout_cubit.dart';
import '../sections/checkout_section.dart';

class CheckoutView extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String restaurantId;
  final double totalPrice;

  const CheckoutView({
    super.key,
    required this.items,
    required this.restaurantId,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CheckoutCubit>(),
      child: CheckoutSection(
        items: items,
        restaurantId: restaurantId,
        totalPrice: totalPrice,
      ),
    );
  }
}
