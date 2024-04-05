import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentController {
  Map<String, dynamic>? paymentIntentData;

  Future<PaymentIntent> stripeCheckPaymentIntentTransaction(String piId) async {
    try {
      // Initialize Stripe with your publishable key
      Stripe.publishableKey =
          'pk_test_51OuFaT00cpr6c22EPbiASuCZtGuUhGNbYVPnBWSa7qD1XakSzGclaIXRbOzgkbA4J8IaVHxxjWfVbt2jPRcvcwMc00Eh8xvPlm';

      // Retrieve payment intent using its ID
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(piId);

      // Return the payment intent

      print(
          "===========================================> paymentIntent $paymentIntent");
      return paymentIntent;
    } catch (e) {
      // Handle any errors
      print('Error fetching payment intent: $e');
      throw e;
    }
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent("6", "USD");
      if (paymentIntentData != null) {
        await Stripe.instance
            .initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
          // billingDetails: const BillingDetails(
          //     name: 'Siam Prodhan',
          //     email: 'siamjht@gmail.com',
          //     phone: '01712345678',
          //     address: Address(
          //         city: 'New York City',
          //         country: 'United States',
          //         line1: 'New York City',
          //         line2: 'New York City',
          //         postalCode: '12345',
          //         state: 'New York City')
          // ),
          // googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
          merchantDisplayName: 'Naimul Hassan',
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          style: ThemeMode.dark,
        ))
            .then((value) {
          print('Is completed payment properly????????????????');
        });
        displayPaymentSheet();
        print("----------display payment sheet didn't called");
      }
    } catch (e, s) {
      print('-=-=-=-=-=-=-=---=-=-=-exception: $e $s =-=-=-=-=--=-=-=-=-=-=-=');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          // headers: {
          //   'Authorization' : 'Bearer sk_test_51NsL1qAGQlA3WKiItI5TaZRQlYgxUxxJatB27Dqp9MeBJQo1AH7LrQ1VK2FSYLfgLPXFKOpp3no9ii8XEgSbfgPV008CBSw9Z8',
          //   'Content-Type' : 'application/x-www-form-urlencoded'
          // }
          headers: {
            'Authorization':
                'Bearer sk_test_51OuFaT00cpr6c22EaepfzgtLDqaPXVJKCpGVGFvF3LjhmPMZg02U7HgYMzpPlpi2T5w4EmjFsAkVmry1ZYlweyXu00T5ujqx3N',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print(
          "=============>>>${response.body}----${response.statusCode}<<<==================");

      return jsonDecode(response.body);
    } catch (e) {
      print("Error Occurred:======================> ${e.toString()}");
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      stripeCheckPaymentIntentTransaction(paymentIntentData!['client_secret']);
      print('payment intent' + paymentIntentData!['client_secret'].toString());
      print('payment intent' + paymentIntentData!['client_secret'].toString());
      print('payment intent' + paymentIntentData!['amount'].toString());
      print('payment intent' + paymentIntentData.toString());
      //orderPlaceApi(paymentIntentData!['id'].toString());
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text("paid successfully")));

      paymentIntentData = null;
    } catch (e) {
      print("error $e");
    }
  }
}
