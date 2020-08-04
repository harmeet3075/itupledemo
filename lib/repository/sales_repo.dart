import 'package:itupledemo/rest/api_provider.dart';
import 'package:itupledemo/rest/response/sales/sale.dart';
import 'package:itupledemo/utils/AppConstants.dart';

class SalesRepo{


  ApiProvider _apiProvider = new ApiProvider();


  Future<Sale> fetchSales()async{
    var resp = await _apiProvider.getResponse(AppConstants.CURRENT_SALE_END_POINT);
    Sale sale = Sale.fromJson(resp);
    return sale;
  }
}