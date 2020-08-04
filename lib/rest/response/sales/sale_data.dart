class SaleData{

  final double onlineSale;
  final double cashSale;
  final double khataSale;

  SaleData({this.onlineSale,this.cashSale,this.khataSale});

  factory SaleData.fromJson(Map<String,dynamic>json){

    return SaleData(
      onlineSale: json['onlineSale'],
      cashSale: json['cashSale'],
      khataSale: json['khataSale'],
    );
  }

  @override
  String toString() {
    return 'SaleData{onlineSale: $onlineSale, cashSale: $cashSale, khataSale: $khataSale}';
  }


}