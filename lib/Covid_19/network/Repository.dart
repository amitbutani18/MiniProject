import 'package:miniProject/Covid_19/models/RpGlobal.dart';
import 'package:miniProject/Covid_19/models/RpLatest.dart';
import 'package:miniProject/Covid_19/models/RpNews.dart';
import 'package:miniProject/Covid_19/network/ApiProvider.dart';

class Repository {
  var apiProvider = ApiProvider();
  Future<RpLatest> getGloballyLatestData() =>
      apiProvider.getGloballyLatestData();
  Future<List<Country>> getAllCountriesData() =>
      apiProvider.getAllCountriesData();
  Future<Country> getUserCountryData(String countryCode) =>
      apiProvider.getUserCountryData();
  Future<RpNews> getNewses() => apiProvider.getNewses();
}
