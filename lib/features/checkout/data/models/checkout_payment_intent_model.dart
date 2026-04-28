import 'package:json_annotation/json_annotation.dart';

part 'checkout_payment_intent_model.g.dart';

@JsonSerializable()
class CheckoutPaymentIntentModel {
  final String clientSecret;
  final String? publishableKey;

  const CheckoutPaymentIntentModel({
    required this.clientSecret,
    this.publishableKey,
  });

  factory CheckoutPaymentIntentModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPaymentIntentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutPaymentIntentModelToJson(this);
}
