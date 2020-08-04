import 'dart:async';

import 'package:itupledemo/bloc/bloc.dart';
import 'package:itupledemo/repository/orders_repo.dart';
import 'package:itupledemo/rest/Response.dart';
import 'package:itupledemo/rest/response/orders/order.dart';

class OrdersBloc extends Bloc{

  OrdersRepo _ordersRepo;

  StreamController<Response<Order>> _orderStreamController;

  Stream<Response<Order>> get orderStream =>_orderStreamController.stream;

  StreamSink<Response<Order>> get orderSink=>_orderStreamController.sink;



  OrdersBloc(){


    _orderStreamController = new StreamController<Response<Order>>();
    _ordersRepo = new OrdersRepo();
    fetchOrders();
  }

  void fetchOrders()async{

    orderSink.add(Response.loading('Fetching orders....'));
    try{
      Order resp = await _ordersRepo.fetchOrders();
      print(resp);
      orderSink.add(Response.completed(resp));
    }catch(e){
      orderSink.add(Response.error(e.toString()));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _orderStreamController?.close();
  }

}