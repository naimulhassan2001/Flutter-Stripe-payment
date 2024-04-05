import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe_payment/view/screen/stripe_payment_sereen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Stripe.publishableKey = "pk_test_51OuFaT00cpr6c22EPbiASuCZtGuUhGNbYVPnBWSa7qD1XakSzGclaIXRbOzgkbA4J8IaVHxxjWfVbt2jPRcvcwMc00Eh8xvPlm";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: StripePaymentScreen(),
    );
  }
}
