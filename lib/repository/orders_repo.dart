import 'package:itupledemo/rest/api_provider.dart';
import 'package:itupledemo/rest/response/orders/order.dart';
import 'package:itupledemo/utils/AppConstants.dart';

class OrdersRepo{


  ApiProvider _apiProvider = new ApiProvider();


  Future<Order> fetchOrders()async{
    var resp = await _apiProvider.getResponse(AppConstants.CURRENT_ORDER_END_POINT);
    Order popular = Order.fromJson(resp);
    return popular;
  }
}