import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../constants.dart';
import '../widgets/CustomElevatedButton.dart';
import 'DisclaimerPage.dart';
import 'FilterPage.dart';
import 'InstructionsPage.dart';
import 'PremiumPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLocked = true; // Initialize with true, assuming initially locked

  @override
  void initState() {
    super.initState();
    //checkSubscriptionStatus();
  }

  Future<void> checkSubscriptionStatus() async {
    try {
      // Your subscription status checking logic here
      CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
      bool isSubscribed = purchaserInfo.entitlements.all['premium']?.isActive ?? false;
      // Update the _isLocked state based on subscription status
      setState(() {
        _isLocked = !isSubscribed; // Update _isLocked based on subscription status
      });
    } catch (e) {
      print("Error checking subscription status: $e");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Perform initialization tasks here
    print("didChangeDependencies...");
    checkSubscriptionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 5, right: 5, bottom: 2),
              child: Text(
                'Nighthawk Stock Scanner',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 5, right: 5, bottom: 2),
              child: Hero(
                tag: 'banner',
                child: Image(
                  image: AssetImage('assets/heroBanner.png'),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    image: 'assets/scanner.png',
                    text: 'Stock Scanner',
                    page: FilterPage(),
                  ),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                    image: 'assets/instructions.png',
                    text: 'Instructions',
                    page: InstructionPage(),
                  ),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                    image: 'assets/disc.png',
                    text: 'Disclaimer',
                    page: DisclaimerPage(),
                  ),
                  SizedBox(height: 20),
                  if (_isLocked) // Render the button only if it's locked
                    CustomElevatedButton(
                      image: 'assets/lock(2).png',
                      text: 'Unlock Premium Access',
                      page: PremiumPage(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
