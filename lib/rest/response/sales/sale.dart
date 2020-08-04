import 'package:itupledemo/rest/response/sales/sale_data.dart';

class Sale{

  final SaleData saleData;
  
  Sale({this.saleData});
  
  factory Sale.fromJson(Map<String,dynamic> json){
    
    return Sale(
      saleData: SaleData.fromJson(json['data'])
    );
  }

  @override
  String toString() {
    return 'Sale{saleData: $saleData}';
  }


}