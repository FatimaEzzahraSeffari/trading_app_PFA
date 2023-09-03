import 'package:flutter/material.dart';
import 'package:trading/constants.dart';
import '../widgets/BuildStepWidgets.dart';
import '../widgets/CustomAppBar.dart';

class InstructionPage extends StatefulWidget {
  const InstructionPage({Key? key}) : super(key: key);

  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Instructions'),
      body: Container(
        color: darkTheme.primaryColor,
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 5.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: darkTheme.colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          padding: const EdgeInsets.only(top: 5.0, left: 16.0, right: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 16.0),
              buildStep(
                'Use our stock scanner every night to find today\'s hottest stocks! The data automatically updates daily one hour after the market closes so you can easily review the day\'s action.',
              ),
              const SizedBox(height: 16.0),
              buildStep(
                'Use the filters on the scanner to adjust what criteria you wish to see:',
              ),
              const SizedBox(height: 8.0),
              buildSubStep(
                'The price slider can be adjusted from \$0 to \$20+. If you only want to view stocks between \$3 and \$5, just move the points on the slider to \$3 and \$5!',
              ),
              buildSubStep(
                'The percent change area allows you to pick between stocks that fell more than 10%, all stocks that were red on the day, all stocks that were green on the day, and stocks that went up more than 10%.',
              ),
              buildSubStep(
                'Select a market capitalization and volume range, then click SHOW MATCHES.',
              ),
              const SizedBox(height: 16.0),
              buildStep(
                'You will see a table of all the stocks that matched your criteria. You can then sort the table by any column and even click on a stock to view a stock chart thanks to TradingView.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
