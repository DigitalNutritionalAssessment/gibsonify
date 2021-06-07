import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class UIData {
  //routes
  static const String homeRoute = "/home";

  static const String testRoute = "/New Test";

  static const String newCollectionSessionRoute = "/New Collection";
  static const String ViewDataRoute = "/View Data";
  static const String NewRecipeRoute = "/Add New Recipe";
  static const String ViewRecipeRoute = "/View Recipes";


  static const String profileOneRoute = "/View Profile";
  static const String profileTwoRoute = "/Profile 2";
  static const String notFoundRoute = "/No Search Result";
  static const String timelineOneRoute = "/Feed";
  static const String timelineTwoRoute = "/Tweets";
  static const String settingsOneRoute = "/Settings";
  // static const String shoppingOneRoute = "/Shopping List";
  // static const String shoppingTwoRoute = "/Shopping Details";
  // static const String shoppingThreeRoute = "/Product Details";
  // static const String paymentOneRoute = "/Credit Card";
  // static const String paymentTwoRoute = "/Payment Success";
  static const String loginRoute = "/Login";
  static const String dashboardOneRoute = "/Dashboard 1";
  static const String dashboardTwoRoute = "/Dashboard 2";


  //strings
  static const String appName = "ICRISAT";

  //fonts
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";

  //images
  static const String imageDir = "assets/images";
  static const String logoImage = "$imageDir/logo.png";
  static const String iconImage = "$imageDir/logo_circle.png";
  static const String pkImage = "$imageDir/ck.jpg";
  static const String profileImage = "$imageDir/profile.jpg";
  static const String blankImage = "$imageDir/blank.jpg";
  static const String dashboardImage = "$imageDir/dashboard.jpg";
  static const String loginImage = "$imageDir/login.jpg";
  static const String paymentImage = "$imageDir/payment.jpg";
  static const String settingsImage = "$imageDir/setting.jpeg";
  static const String shoppingImage = "$imageDir/shopping.jpeg";
  static const String timelineImage = "$imageDir/timeline.jpeg";
  static const String verifyImage = "$imageDir/verification.jpg";


  //login
  //mainly used for commonly used validation, would be good to add to this list
  static const String enter_code_label = "Phone Number";
  static const String enter_code_hint = "10 Digit Phone Number";
  static const String enter_otp_label = "OTP";
  static const String enter_otp_hint = "4 Digit OTP";
  static const String get_otp = "Get OTP";
  static const String resend_otp = "Resend OTP";
  static const String login = "Login";
  static const String enter_valid_number = "Enter 10 digit phone number";
  static const String enter_valid_otp = "Enter 4 digit otp";

  //gneric
  static const String error = "Error";
  static const String success = "Success";
  static const String ok = "OK";
  static const String forgot_password = "Forgot Password?";
  static const String something_went_wrong = "Something went wrong";
  static const String coming_soon = "Coming Soon";

  static const MaterialColor ui_kit_color = Colors.grey;

//colors
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];

  //randomcolor
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }

  //Default Text Style
  static const TextStyle smallTextStyle  = TextStyle(
    fontWeight: FontWeight.normal,
    fontFamily: UIData.ralewayFont,
  );

  static const TextStyle smallTextStyle_GreyedOut  = TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.grey,
    fontFamily: UIData.ralewayFont,
  );

  static const TextStyle titleTextStyle  = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: UIData.ralewayFont,
    decoration: TextDecoration.underline,
    fontSize: 18.0,
  );

//  static const TextStyle smallTextStyle_Bold  = TextStyle(
//    fontWeight: FontWeight.bold,
//    fontFamily: UIData.ralewayFont,
//  );

  //Default edge_insets
  static const double collection_edge_inset = 9.0;

  //Default API URL
  // ignore: non_constant_identifier_names
  static String api_base_url = "https://deleo.serveo.net";
  static const String send_consumption_data_api_path = "/processjson";

  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }
}
