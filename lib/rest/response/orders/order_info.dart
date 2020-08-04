import 'package:itupledemo/rest/response/orders/customer.dart';
import 'package:itupledemo/rest/response/orders/payment.dart';

class OrderInfo{

  final String createdOn;
  final String mode;
  final bool pack;
  final String status;
  final Customer customer;
  final Payment payment;

  OrderInfo({this.createdOn,this.pack,this.customer,this.payment,this.mode,this.status});

  factory OrderInfo.fromJson(Map<String , dynamic> json){

    return OrderInfo(
      createdOn: json['createdOn'],
      mode: json['mode'],
      pack: json['pack'],
      status: json['status'],
      customer: Customer.fromJson(json['customer']),
      payment: Payment.fromJson(json['payment'])
    );
  }

  @override
  String toString() {
    return 'OrderInfo{createdOn: $createdOn, mode: $mode, pack: $pack, '
        'status: $status, customer: $customer, payment: $payment}';
  }


}