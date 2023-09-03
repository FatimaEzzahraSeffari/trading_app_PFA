import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/offerings_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../constants.dart';
import '../widgets/CustomAppBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DisclaimerPage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'HomePage.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  //show product price from google play console
  InAppPurchase _inAppPurchase = InAppPurchase.instance;
  List<ProductDetails> _products = [];
  void _initStore() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      // In-app purchases are not available on this device
      return;
    }
    // Define the product IDs for the products you want to fetch
    Set<String> productIds = {"monthly_sub", "yearly_sub"};
    // Load the products from the Google Play Console
    ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(productIds);
    if (mounted) {
      setState(() {
        _products = response.productDetails;
      });
    }
  }

  String getProductPrice(String productId) {
    if (_products != null && _products.isNotEmpty) {
      ProductDetails? product =_products.firstWhereOrNull((product) => product.id == productId);
      print("Product: $product");
      print("Product Price: ${product?.price}");
      return product?.price ?? "the _products list is not available";
    }
    return "the _products list is not available";
  }

  String getProductTitle(String productId) {
    if (_products != null && _products.isNotEmpty) {
      ProductDetails? product =_products.firstWhereOrNull((product) => product.id == productId);
      print("Product: $product");
      print("Product Title: ${product?.title}");

      if (product != null && product.title != null) {
        int openingParenIndex = product.title.indexOf('(');
        String titleWithoutBrackets = (openingParenIndex != -1)
            ? product.title.substring(0, openingParenIndex).trim()
            : product.title;
        return titleWithoutBrackets;
      }
    }
    return "the _products list is not available";
  }

  void navigateToHomePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()), // Use the actual homepage class
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _initStore();
  }

  //fetch offers
  void fetchOfferingsAndShowDialog(int i) async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current!.availablePackages.isNotEmpty) {
        //verify if the purchaser active or not
        Package package = offerings.current!.availablePackages[i];
        CustomerInfo purchaserInfo = await Purchases.purchasePackage(package);
        if (purchaserInfo?.entitlements.all["premium"]?.isActive == true) {
          
          navigateToHomePage();
          // Show a dialog to inform the user about the successful upgrade
          /*
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Upgrade Successful"),
                content: Text("Thank you for upgrading to Premium! Enjoy the app."),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Close the current dialog
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
          */
        }
      }
    } on PlatformException catch (e) {
      // optional error handling
      print("PlatformException: ${e.message}");
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Upgrade'),
      body: Container(
        color: darkTheme.primaryColor,
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 5.0,
          left: 10.0,
          right: 12.0,
          bottom: 16.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: darkTheme.colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          padding: const EdgeInsets.only(
            top: 5.0,
            left: 16.0,
            right: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 6),
                        Text(
                          "Thank you for considering upgrading.\n\n"
                          "This app incurs various expenses from stock market providers, hosting, and marketplace fees. "
                          "Viewing all stocks from \$2 - \$18 will always be free, but subscribing will allow screening with no restrictions.\n\n"
                          "View all stocks from \$0.01 to \$100+ !\n\n"
                          "This daytrader-built app will always re-invest proceeds from supporters. Future plans include symbol lookup, "
                          "favorites list, information search, and a newsfeed.\n\n"
                          "While basic, I truly think this is the best way to view the day's top stocks from a mobile device.\n\n"
                          "Thank you!",
                          style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                        for (int i = 0; i < _products.length; i++)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                fetchOfferingsAndShowDialog(i);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 75),
                                minimumSize: Size(200, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      width: 110,
                                      height: 45,
                                      child: Text('${getProductTitle(_products[i].id)}',
                                        style: GoogleFonts.poppins(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(' ${getProductPrice(_products[i].id)} /${_products[i].id.contains("yearly_sub") ? "Year" : "Month"}.',
                                        style: GoogleFonts.poppins(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
