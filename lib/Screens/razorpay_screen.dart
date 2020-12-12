import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniProject/Helpers/doctor_list_obj.dart';
import 'package:miniProject/Screens/dashboard.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayScreen extends StatefulWidget {
  static String tag = '/RazorPayScreen';

  final DoctorListObj personalDetails;

  RazorPayScreen({@required this.personalDetails});

  @override
  RazorPayScreenState createState() => RazorPayScreenState();
}

class RazorPayScreenState extends State<RazorPayScreen> {
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': 2000,
      'name': widget.personalDetails.personalDetails.name,
      'description': 'Appointment',
      'prefill': {
        'contact': "8347055891",
        'email': widget.personalDetails.personalDetails.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    toast("SUCCESS: " + response.paymentId);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    toast("ERROR: " + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    toast("EXTERNAL_WALLET: " + response.walletName);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    // changeStatusColor(primaryColor);
    return Scaffold(
      // appBar: getAppBar(context, 'RazorPay Payment checkout'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 24, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(left: 16, right: 16, bottom: 28),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(8)),
                  //       boxShadow: [
                  //         BoxShadow(
                  //             // color: shadowColor,
                  //             blurRadius: 10,
                  //             spreadRadius: 2)
                  //       ],
                  //       color: whiteColor),
                  //   child: Image.asset(
                  //     "images/integrations/icons/ic_razorpay.png",
                  //     width: 120,
                  //     height: 120,
                  //   ),
                  // ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Docnet",
                          // fontSize: textSizeLarge,
                          // fontFamily: fontMedium,
                          // textColor: Colors.lightBlue[600],
                        ),
                        Text(
                          "Order#567880",
                          // fontSize: textSizeMedium,
                          // textColor: Theme.of(context).secondaryHeaderColor,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "\$200",
                          // fontSize: textSizeXLarge,
                          // fontFamily: fontMedium,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Divider(height: 0.5),
              Text(
                "Name",
                // textColor: primaryColor,
                // fontFamily: fontSemibold,
                // fontSize: textSizeLargeMedium,
              ).paddingAll(16),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).dividerColor, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text(widget.personalDetails.personalDetails.name),
              ),
              Text(
                "Email",
                // textColor: primaryColor,
                // fontFamily: fontSemibold,
                // fontSize: textSizeLargeMedium,
              ).paddingAll(16),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).dividerColor, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text(widget.personalDetails.personalDetails.email),
              ),
              Text(
                "Contact",
                // textColor: primaryColor,
                // fontFamily: fontSemibold,
                // fontSize: textSizeLargeMedium,
              ).paddingAll(16),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).dividerColor, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text("837058910"),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 80),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  'Pay with RazorPay',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ).onTap(() {
                openCheckout();
              })
            ],
          )

          /*MaterialButton(
            color: primaryColor,
            onPressed: () => openCheckout(),
            child: textPrimary('Pay with RazorPay'),
          )*/
          ,
        ),
      ),
    );
  }
}
