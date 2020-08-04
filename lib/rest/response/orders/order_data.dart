import 'package:itupledemo/rest/response/orders/order_info.dart';

class OrderData{

  final List<OrderInfo> orders;

  OrderData({this.orders});

  factory OrderData.fromJson(Map<String,dynamic> json){

    return OrderData(
      orders:(json['orders']==null)?new List<OrderInfo>(0):
      (json['orders'] as List).map((i)=>OrderInfo.fromJson(i)).toList()
    );
  }

  @override
  String toString() {
    return 'OrderData{orders: $orders}';
  }


}