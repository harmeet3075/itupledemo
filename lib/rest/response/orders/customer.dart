class Customer{

  final String name;

  Customer({this.name});

  factory Customer.fromJson(Map<String,dynamic> json){

    return Customer(
      name: json['name']
    );
  }

  @override
  String toString() {
    return 'Customer{name: $name}';
  }


}