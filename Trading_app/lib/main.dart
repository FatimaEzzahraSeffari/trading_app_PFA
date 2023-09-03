import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:trading/pages/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.setLogLevel(LogLevel.debug);
  PurchasesConfiguration pc = PurchasesConfiguration("goog_EzHXVCcfWlOAfgxzWWywnfTMvoe");
  await Purchases.configure(pc);

  // Check subscription status before running the app
  await checkSubscriptionStatus();

  runApp(const MyApp());
}

Future<void> checkSubscriptionStatus() async {
  try {
    // Get the current active subscription
    CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
    bool isSubscribed = purchaserInfo.entitlements.all['premium']?.isActive ?? false;

    // You can use this subscription status information as needed
    print("User subscription status: $isSubscribed");
  } catch (e) {
    // Handle any errors that might occur during the subscription check
    print("Error checking subscription status: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
