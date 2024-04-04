import 'package:flutter/material.dart';
import 'package:flutter_stripe_payment/controller/stripe_payment_controller.dart';
import 'package:get/get.dart';

class StripePaymentScreen extends StatelessWidget {
  StripePaymentScreen({super.key});

  PaymentController paymentController = PaymentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: ElevatedButton(
                onPressed: () async {
                  await paymentController.makePayment();
                },
                child: const Text("Pay")))
      ],
    ));
  }
}
