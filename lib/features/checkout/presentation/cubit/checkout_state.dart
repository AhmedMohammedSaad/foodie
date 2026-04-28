part of 'checkout_cubit.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutPaymentIntentCreated extends CheckoutState {
  final CheckoutPaymentIntentModel paymentIntent;
  CheckoutPaymentIntentCreated(this.paymentIntent);
}

class CheckoutPaymentSuccess extends CheckoutState {}

class CheckoutError extends CheckoutState {
  final String message;
  CheckoutError(this.message);
}
