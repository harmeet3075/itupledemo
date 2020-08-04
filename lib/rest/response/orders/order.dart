import 'package:itupledemo/rest/response/orders/order_data.dart';

class Order{

  final String message;
  final OrderData orderData;

  Order({this.message,this.orderData});

  factory Order.fromJson(Map<String,dynamic> json){

    return Order(
      message: json['message'],
      orderData: OrderData.fromJson(json['data'])
    );
  }

  @override
  String toString() {
    return 'Order{message: $message, orderData: $orderData}';
  }


}