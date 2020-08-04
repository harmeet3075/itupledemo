import 'dart:async';

import 'package:itupledemo/bloc/bloc.dart';
import 'package:itupledemo/repository/orders_repo.dart';
import 'package:itupledemo/repository/sales_repo.dart';
import 'package:itupledemo/rest/Response.dart';
import 'package:itupledemo/rest/response/orders/order.dart';
import 'package:itupledemo/rest/response/sales/sale.dart';

class SalesBloc extends Bloc{

  SalesRepo _salesRepoRepo;

  StreamController<Response<Sale>> _salesStreamController;

  Stream<Response<Sale>> get salesStream =>_salesStreamController.stream;

  StreamSink<Response<Sale>> get salesSink=>_salesStreamController.sink;



  SalesBloc(){


    _salesStreamController = new StreamController<Response<Sale>>();
    _salesRepoRepo = new SalesRepo();
    fetchSales();
  }

  void fetchSales()async{

    salesSink.add(Response.loading('Fetching sales....'));
    try{
      Sale resp = await _salesRepoRepo.fetchSales();
      print(resp);
      salesSink.add(Response.completed(resp));
    }catch(e){
      salesSink.add(Response.error(e.toString()));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _salesStreamController?.close();
  }

}