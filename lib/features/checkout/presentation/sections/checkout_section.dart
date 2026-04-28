import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/presentation/view/widgets/app_default_button.dart';
import '../../../../core/presentation/view/widgets/app_toast.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/checkout_cubit.dart';

class CheckoutSection extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String restaurantId;
  final double totalPrice;

  const CheckoutSection({
    super.key,
    required this.items,
    required this.restaurantId,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutPaymentSuccess) {
            AppToast.showSuccess(context, 'Payment Successful!');
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.home, (route) => false);
          } else if (state is CheckoutError) {
            AppToast.showError(context, state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const Divider(height: 30),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.offWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.fastfood, color: AppColors.primary),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] ?? 'Item',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Quantity: ${item['quantity']}',
                                style: const TextStyle(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${(double.parse(item['price'].toString()) * int.parse(item['quantity'].toString())).toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              BlocBuilder<CheckoutCubit, CheckoutState>(
                builder: (context, state) {
                  return AppDefaultButton(
                    onPressed: state is CheckoutLoading
                        ? () {} // Dummy function if loading, or handle state correctly
                        : () {
                            final userId =
                                Supabase.instance.client.auth.currentUser?.id;
                            if (userId != null) {
                              context.read<CheckoutCubit>().startCheckout(
                                    items: items,
                                    restaurantId: restaurantId,
                                    userId: userId,
                                  );
                            } else {
                              AppToast.showError(context, 'Please login to proceed');
                            }
                          },
                    text: state is CheckoutLoading ? 'Processing...' : 'Pay with Stripe',
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
