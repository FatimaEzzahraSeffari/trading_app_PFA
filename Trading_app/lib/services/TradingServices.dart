import 'package:http/http.dart' as http;
import 'dart:convert';

class TradingService {
  static Future<List<dynamic>> fetchData(int inputVolume , int isAbove10 ,double priceRangeMin ,double priceRangeMax ,int inputMarketCap) async {
    final response = await http.get(Uri.parse('https://ana.ma/trading_app/json.php'));
    if (response.statusCode == 200) {
      print("**************service************");
      print("Price Range: $priceRangeMin - $priceRangeMax");
      print("Volume: $inputVolume");
      print("Percent Change: $isAbove10");
      print("Market Cap: $inputMarketCap");
      final jsonData = json.decode(response.body);
      final filteredData = jsonData.where((item) {
        final close = double.tryParse(item['Close']);
        final volume = int.tryParse(item['Volume']);
        final percentChange = double.tryParse(item['percent_change']);
        final marketCap = int.tryParse(item['MarketCapitalization']);
        if(priceRangeMax == 20) {
          return  close!>=priceRangeMin && volume != null && volume > inputVolume && (isAbove10 == 0 ? percentChange! < -10 : (isAbove10 == 1 ? percentChange! < 0 : (isAbove10 == 2 ? percentChange! > 0 :  percentChange! > 10))) && marketCap! < inputMarketCap;
        } else {
          return  close!>=priceRangeMin && close <=priceRangeMax && volume != null && volume > inputVolume && (isAbove10 == 0 ? percentChange! < -10 : (isAbove10 == 1 ? percentChange! < 0 : (isAbove10 == 2 ? percentChange! > 0 :  percentChange! > 10))) && marketCap! < inputMarketCap ;
        }
      }).toList();
      print("filter");
      return filteredData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
