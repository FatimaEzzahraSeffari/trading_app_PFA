import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../widgets/CustomAppBar.dart';

class DisclaimerPage extends StatefulWidget {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  State<DisclaimerPage> createState() => _DisclaimerPageState();
}

class _DisclaimerPageState extends State<DisclaimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Disclaimer'),
      body: Container(
        color: darkTheme.primaryColor,
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.only( top: 5.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: darkTheme.colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: ListView(
            children: [
              Text('We are not registered as a securities broker-dealer or an investment adviser with the U.S. Securities and Exchange Commission (the SEC) or with any state securities regulatory authority. We are neither licensed nor qualified to provide investment advice. The information contained in our mobile application is not intended to be investment advice. The information contained in our mobile application is not an offer to buy or sell securities. Any individual who chooses to invest in any securities should do so with caution. Investing in securities is speculative and carries a high degree of risk; you may lose some or all of the money that is invested. Always research your own investments and consult with a registered investment advisor or licensed stock broker before investing. While all information is believed to be reliable, it is not guaranteed by us to be accurate. The information is for entertainment purposes only. Individuals should assume that all information contained in our mobile application is not trustworthy unless verified by their own independent research. Always consult a real licensed investment professional before making any investment decision. Be extremely careful, investing in securities carries a high degree of risk; you may likely lose some or all of the investment. To the fullest extent of the law, we will not be liable to any person or entity for the quality, accuracy, completeness, reliability, or timeliness of the information provided in the mobile application or for any direct, indirect, consequential, incidental, special or punitive damages that may arise out of the use of information we provide to any person or entity (including, but not limited to, lost profits, loss of opportunities, trading losses, and damages that may result from any inaccuracy or incompleteness of this information). We encourage you to invest carefully and read investment information available at the SEC at http://www.sec.gov and FINRA at http://www.finra.org.',
                style: GoogleFonts.poppins(fontSize: 16.0,color: const Color(0xFFACACBE),),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
