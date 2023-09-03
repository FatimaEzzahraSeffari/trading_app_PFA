import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:trading/constants.dart';
import 'package:trading/widgets/CustomAppBar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:trading/widgets/VolumeButtons.dart';
import '../widgets/MarketCapButtons.dart';
import '../widgets/PercentButtons.dart';
import 'PremiumPage.dart';
import 'TablePage.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  SfRangeValues _priceRange = const SfRangeValues(2.0, 18.0);
  int _isAbove10 = 3;
  int _volume = 1;
  int _marketCap = 99999999999999;
  bool _isLocked = false;

  void checkSubscriptionStatus() async {
    print("checkSubscriptionStatus...");
    try {
      // Initialize RevenueCat
      await Purchases.configure(PurchasesConfiguration("goog_EzHXVCcfWlOAfgxzWWywnfTMvoe"));
      // Get the current active subscription
      CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
      bool isSubscribed = purchaserInfo.entitlements.all['premium']?.isActive ?? false;
      
      // If the user is subscribed, set _isLocked to false
      print("isSubscribed = $isSubscribed");
      setState(() {
        _isLocked = !isSubscribed;
        print("_isLocked = $_isLocked");
      });
    } catch (e) {
      print("Error checking subscription status: $e");
    }
  }
  Color SetLockedColor(SfRangeValues rangeValues) {
    final double start = rangeValues.start;
    final double end = rangeValues.end;
    print("1___ _isLocked = $_isLocked");
    if(_isLocked){
      if (start < 2 || end > 18) {
          return Colors.red; // locked interval from 4 to  16
      } 
    }
    return Colors.grey; // default color for other intervals
   
  }
  @override
  void initState() {
    super.initState();
    //checkSubscriptionStatus();
  }
  bool disable(SfRangeValues rangeValues) {
    final double start = rangeValues.start;
    final double end = rangeValues.end;
    print("disable function...");
    print("2___ _isLocked = $_isLocked");
    if(_isLocked){
      if (start < 2 || end > 18) {
        return true; // locked interval from 4 to  16
      }
    }
    return false;
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
      appBar: CustomAppBar(title: 'Nighthawk Stocks',),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: darkTheme.primaryColor,
        padding: const EdgeInsets.only(top: 25.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Price',
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              SfRangeSelectorTheme(
                data: SfRangeSelectorThemeData(
                  thumbColor: SetLockedColor(_priceRange),
                  activeTrackColor: SetLockedColor(_priceRange),
                  tooltipBackgroundColor: SetLockedColor(_priceRange),
                  inactiveTrackColor: Colors.white,
                  inactiveRegionColor: darkTheme.primaryColor,
                  activeLabelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                  inactiveLabelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                child: SfRangeSelector(
                  enableTooltip: true,
                  tooltipShape: const SfPaddleTooltipShape(),
                  min: 0,
                  max: 20,
                  stepSize: 1,
                  labelFormatterCallback: (dynamic actualValue, String formattedText) { return actualValue == 20 ? '$formattedText+' : formattedText; },
                  initialValues: _priceRange,
                  interval: 2,
                  showTicks: true,
                  showLabels: true,
                  onChanged: (values) {
                    setState(() {
                      print("start = " + values.start.toString());
                      print("end = " + values.end.toString());
                      if (values.start == values.end) {
                        print("equals");
                        // Adjust the start or end value
                        if (values.start > 0) {
                          _priceRange = SfRangeValues(values.start - 1, values.end);
                          print(_priceRange);
                        } else {
                          _priceRange = SfRangeValues(values.start, values.end + 1);
                        }
                      } else {
                        _priceRange = values;
                      }
                    });
                  },
                  child: const SizedBox(
                    height: 20,
                    width: 300,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Percent Change',
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              PercentChargeButtons(
                selectedButton: _isAbove10,
                onButtonPressed: (int value) {
                  setState(() {
                    _isAbove10 = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              Text(
                'Market Capitalization',
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              MarketCapButtons(
                marketCap: _marketCap,
                onMarketCapSelected: (int value) {
                  setState(() {
                    _marketCap = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              Text(
                'Volume',
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              VolumeButtons(
                volume: _volume,
                onVolumeSelected: (int value) {
                  setState(() {
                    _volume = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(220, 50),
                    backgroundColor: disable(_priceRange) ? Colors.red : Colors.grey),
                  onPressed: disable(_priceRange) ? () {
                    // Redirect to PremiumPage when the button is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PremiumPage()),  );} :() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TablePage(
                          priceRangeMin: _priceRange.start,
                          priceRangeMax: _priceRange.end,
                          volume: _volume,
                          isAbove10: _isAbove10,
                          marketCap: _marketCap,
                        ),
                      ),
                    );
                  },
                  child: Text(
                      disable(_priceRange) ? 'Upgrade To premium' : 'Show Matches',
                      style: GoogleFonts.poppins(
                        color: disable(_priceRange) ? Color.fromARGB(255, 255, 255, 255) : Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
