import 'package:dio/dio.dart';
import 'package:subscription_mobile_app/SecondPage/dashboard_items_dbprovider.dart';
import 'package:subscription_mobile_app/models/dashboardItems_model.dart';

class DataApiProvider {
  Future<List<GetPackage?>> getAllPackages() async {
    var url = "https://foodapi.pos53.com/api/Food/GetPackage";
    Response response = await Dio().post(url);
    // final items =
    //     (response.data['data'] as List).map((i) => new Data.fromJson(i));
    // print(items);
    return (response.data['data'] as List).map(
      (element) {
        DBProvider.db.createData(GetPackage.fromJson(element));
      },
    ).toList();
  }
}
