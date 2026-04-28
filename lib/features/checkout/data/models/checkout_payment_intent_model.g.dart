// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_payment_intent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutPaymentIntentModel _$CheckoutPaymentIntentModelFromJson(
  Map<String, dynamic> json,
) => CheckoutPaymentIntentModel(
  clientSecret: json['clientSecret'] as String,
  publishableKey: json['publishableKey'] as String?,
);

Map<String, dynamic> _$CheckoutPaymentIntentModelToJson(
  CheckoutPaymentIntentModel instance,
) => <String, dynamic>{
  'clientSecret': instance.clientSecret,
  'publishableKey': instance.publishableKey,
};
