import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../data/models/checkout_payment_intent_model.dart';
import '../../domain/usecases/initiate_checkout_usecase.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final InitiateCheckoutUseCase initiateCheckoutUseCase;

  CheckoutCubit({required this.initiateCheckoutUseCase})
    : super(CheckoutInitial());

  Future<void> startCheckout({
    required List<Map<String, dynamic>> items,
    required String restaurantId,
    required String userId,
  }) async {
    emit(CheckoutLoading());

    final result = await initiateCheckoutUseCase.execute(
      items: items,
      restaurantId: restaurantId,
      userId: userId,
    );

    await result.fold(
      (data) async {
        emit(CheckoutPaymentIntentCreated(data));
        await _initPaymentSheet(data.clientSecret, data.publishableKey);
      },
      (failure) async {
        log(failure.message);
        emit(CheckoutError(failure.message));
      },
    );
  }

  Future<void> _initPaymentSheet(
    String clientSecret,
    String? publishableKey,
  ) async {
    try {
      // 1. Set Publishable Key (CRITICAL)
      if (publishableKey != null && publishableKey.isNotEmpty) {
        Stripe.publishableKey = publishableKey;
      }

      // 2. Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Foodie App',
          style: ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xFFFF7622), // App primary color
            ),
          ),
        ),
      );

      // 2. Present Payment Sheet
      await Stripe.instance.presentPaymentSheet();

      emit(CheckoutPaymentSuccess());
    } catch (e) {
      if (e is StripeException) {
        if (e.error.code == FailureCode.Canceled) {
          emit(CheckoutInitial()); // User cancelled, just go back to initial
        } else {
          // log(e.error.localizedMessage.toString());
          emit(CheckoutError('Payment failed: ${e.error.localizedMessage}'));
        }
      } else {
        log(e.toString());
        emit(CheckoutError('An error occurred: $e'));
      }
    }
  }
}
