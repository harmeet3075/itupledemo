class Payment{

  final String mode;
  final double amount;
  final bool paid;

  Payment({this.mode,this.amount,this.paid});

  factory Payment.fromJson(Map<String,dynamic> json){

    return Payment(
      mode: json['mode'],
      amount: json['amount'],
      paid: json['paid']
    );
  }

  @override
  String toString() {
    return 'Payment{mode: $mode, amount: $amount, paid: $paid}';
  }


}