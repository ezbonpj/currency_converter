import 'package:currency_converter/models/allcurrencies.dart';
import 'package:http/http.dart' as http;
import '../models/ratesmodel.dart';

Future<RatesModel> fetchrates() async{
  final response = await http.get(Uri.parse('https://openexchangerates.org/api/latest.json?app_id=b2b8d4f8659e4b378304ae3652680ed2' ));
 print(response.body);
 final result = ratesModelFromJson(response.body);
 return result;
 }

 Future<Map> fetchcurrencies()async{
  final response = await http.get(Uri.parse('https://openexchangerates.org/api/currencies.json?app_id=b2b8d4f8659e4b378304ae3652680ed2'));

final allCurrencies = allCurrenciesFromJson(response.body);
return allCurrencies;

 }
/*
String convertusd(Map exchangeRates, String usd, String currency) {
  String output =
      ((exchangeRates[currency] * double.parse(usd)).toStringAsFixed(2))
          .toString();
  return output;
}*/




 String convertany(Map exchangeRates, String amount, String currencybase, String currencyfinal) {
  String output =
      ((double.parse(amount) / exchangeRates[currencybase]) * exchangeRates[currencyfinal])
          .toStringAsFixed(4).toString();
  return output;
 }