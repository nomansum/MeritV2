import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:merit_tuition_v1/constants/keys.dart';

class StripeAPI {
  static createPaymentIntent(
      String amount, String currency, BuildContext context) async {
    try {
       var name = 'Arnab Saha';
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': "card",
        'customer': name.length.toString()
        
      };
     

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${keys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print(response.body);
      return jsonDecode(response.body);
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

 static Future<void> createStripeCustomer() async {
    var url = 'https://api.stripe.com/v1/customers';
    var name = 'Arnab Saha';
    Map<String, String> headers = {
      'Authorization': 'Bearer ${keys.secretKey}',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    Map<String, String> body = {
      'email': 'customer@example.com',
      'name':name, 
      'id': name.length.toString()// Replace with customer's email
    };

    final response = await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      // Customer created successfully
      print(response);
      print('Customer created successfully');
    } else {
      // Error in creating customer
      print('Error creating customer: ${response.reasonPhrase}');
    }
  }
  static Future<void> makePayment(
      String amount, String currency, BuildContext context) async {
    Map<String, dynamic>? paymentIntentData;
    try {
      paymentIntentData = await createPaymentIntent(amount, currency, context);
     
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                // applePay: const PaymentSheetApplePay(merchantCountryCode: "+1"),
                googlePay:
                    const PaymentSheetGooglePay(merchantCountryCode: "EU"),
                paymentIntentClientSecret: paymentIntentData["client_secret"],
                customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
                merchantDisplayName: "Arnab Saha",
                customerId: "12"));
        print("showing payment gateway");
        await Stripe.instance.presentPaymentSheet();
        
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Payment is successfull"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print(e);
      LocalizedErrorMessage localizedErrorMessage =
          e.reactive.toJson()['error'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(localizedErrorMessage.message.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
}
