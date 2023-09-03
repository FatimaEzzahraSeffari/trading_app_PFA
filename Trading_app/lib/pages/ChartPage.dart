import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:trading/widgets/CustomAppBar.dart';

class ChartPage extends StatelessWidget {
  final String code;
  const ChartPage({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String html = '''
    <!-- TradingView Widget BEGIN -->
    <html style="background-color: rgb(24, 26, 32);">
<div class="tradingview-widget-container" >
  <div id="tradingview_2936b"></div>
  <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/symbols/$code/" rel="noopener" target="_blank">
<span class="blue-text">$code stock chart</span></a> by TradingView</div>
  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
  new TradingView.widget(
  {
  "autosize": true,
  "symbol": "$code",
  "interval": "D",
  "timezone": "Etc/UTC",
  "theme": "dark",
  "style": "1",
  "locale": "en",
  "toolbar_bg": "#f1f3f6",
  "enable_publishing": false,
  "hide_legend": true,
  "save_image": false,
  "container_id": "tradingview_2936b"
}
  );
  </script>
</div>
</html>
<!-- TradingView Widget END -->''';

    return Scaffold(
      appBar: CustomAppBar(title: "$code Chart",),
      body: Container(
        color: Color(0xFF181A20),
        child: InAppWebView(
          initialData: InAppWebViewInitialData(data: html),
        ),
      ),
    );
  }
}
