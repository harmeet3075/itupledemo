

import 'package:itupledemo/bloc/bloc.dart';
import 'package:itupledemo/bloc/orders_bloc.dart';
import 'package:itupledemo/bloc/sales_bloc.dart';

class AppBloc extends Bloc{

  OrdersBloc _ordersBloc;
  SalesBloc  _salesBloc;

  AppBloc(){

    _ordersBloc  = new OrdersBloc();
    _salesBloc = new SalesBloc();
  }

  OrdersBloc get orderBloc =>_ordersBloc;
  SalesBloc get salesBloc =>_salesBloc;


  @override
  void dispose() {
    // TODO: implement dispose
    _ordersBloc?.dispose();
    _salesBloc?.dispose();
  }

}