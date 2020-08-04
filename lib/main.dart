import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itupledemo/bloc/app_bloc.dart';
import 'package:itupledemo/bloc/bloc_provider.dart';
import 'package:itupledemo/rest/Response.dart';
import 'package:itupledemo/rest/Status.dart';
import 'package:itupledemo/rest/response/orders/order.dart';
import 'package:itupledemo/rest/response/orders/order_data.dart';
import 'package:itupledemo/rest/response/orders/order_info.dart';
import 'package:itupledemo/rest/response/sales/sale.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(bloc: AppBloc(), child:MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool selectOngoing = true,selectTomorrow=false,selectHistory = false;
  var selectedOrderType = 0;
  AppBloc _appBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // SystemChrome.setEnabledSystemUIOverlays([]);
    _appBloc = BlocProvider.of<AppBloc>(context);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
         slivers: <Widget>[

            SliverToBoxAdapter(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    topLeft: Radius.circular(0.0),topRight: Radius.circular(0.0)
                  ),
                  gradient: LinearGradient(colors: [Colors.orange,Colors.purple],stops: [0.4,1],
                   begin:Alignment.topLeft,end: Alignment.topRight
      )
                ),
                child: Row(

                  children: <Widget>[

                    Expanded(child: searchBarContainer()),
                    onlineOfflineSwitch(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/demo_img_01.jpg',fit: BoxFit.fill,),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.red,width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: orderInfoRow(),
            ),
            SliverToBoxAdapter(
              child: orderTypeRow(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.access_time,size: 20,color: Colors.orange,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Instant',style: TextStyle(
                        color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold
                      ),),
                    ),
                  ],
                ),
              ),
            ),
           StreamBuilder<Response<Order>>(builder: (context,snapshot){

             if(snapshot.hasData){

               switch(snapshot.data.status){

                 case Status.LOADING:
                 // TODO: Handle this case.
                   return SliverToBoxAdapter(child: Container(child: Center(child: CircularProgressIndicator())));
                 case Status.COMPLETED:
                   return SliverList(delegate: SliverChildBuilderDelegate((BuildContext bc , int index){
                          return orderListItems(snapshot.data.data.orderData.orders[index]);

                        },childCount: snapshot.data.data.orderData.orders.length),);
                 case Status.ERROR:

                   return SliverToBoxAdapter(child: Container());
               }

             }
             return SliverToBoxAdapter(child: Container());



           },stream: _appBloc.orderBloc.orderStream)

         ],
      )

    );
  }

  Widget searchBarContainer(){

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
      child: Container(

        width: 200,
        child: Row(
          children: <Widget>[


            Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 5)
              ,child:InkWell(

                child: Container(

                  child: Icon(Icons.search,size: 20,color: Colors.red,),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0,0),
              child: Text('Search',style: TextStyle(color: Colors.black,fontSize: 14),),
            )
          ],
        ),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color(0xffEAEAEA),
            borderRadius: BorderRadius.all(Radius.circular(12.0))
        ),
      ),
    );
  }

  Widget onlineOfflineSwitch(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Online',style: TextStyle(color: Colors.black,fontSize: 12),),
          Transform.scale(
            scale: 0.5,
            child: CupertinoSwitch(value: true, onChanged: (bool value){

            },activeColor: Colors.red,trackColor: Colors.grey[400],),
          )
        ],
      ),
    );
  }

  Widget orderTypeRow(){

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: orderTypeItem('Ongoing',selectOngoing),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: orderTypeItem('Tomorrow',selectTomorrow),
          ),
          orderTypeItem('History',selectHistory),


        ],
      ),
    );
  }

  Widget orderTypeItem(String orderType,bool _defaultSelection){

    return Container(

      decoration: BoxDecoration(
          color: _defaultSelection?Colors.orange:Colors.white,
          border: Border.all(color:  _defaultSelection?Colors.white60:Colors.grey,width: 0.8),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: InkWell(
        onTap: (){

          setState(() {
            if(orderType=='Ongoing'){
              selectOngoing = true;
              selectTomorrow = false;
              selectHistory = false;
              selectedOrderType = 0;
            }else if(orderType == 'Tomorrow'){
              selectOngoing = false;
              selectTomorrow = true;
              selectHistory = false;
              selectedOrderType = 1;
            }else{
              selectOngoing = false;
              selectTomorrow = false;
              selectHistory = true;
              selectedOrderType = 3;
            }
          });

        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text(orderType,style: TextStyle(fontSize: 16,color: _defaultSelection?Colors.white:Colors.orange),),
        ),
      ),
    );
  }

  Widget orderInfoRow(){
    return StreamBuilder<Response<Sale>>(
      stream: _appBloc.salesBloc.salesStream,
      builder: (context,snapshot){

        if(snapshot.hasData){
          switch(snapshot.data.status){

            case Status.LOADING:
            // TODO: Handle this case.
              return Container(child: Center(child: CircularProgressIndicator()));
            case Status.COMPLETED:
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  orderInfoTile('All Orders',Colors.orange,false,0.0),
                  orderInfoTile('Earnings of the day',Colors.purple,true,snapshot.data.data.saleData.khataSale),
                  orderInfoTile('All Customers',Colors.brown,false,0.0),
                ],
              );
            case Status.ERROR:

              return Container();
          }

        }else{
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              orderInfoTile('All Orders',Colors.orange,false,0.0),
              orderInfoTile('Earnings of the day',Colors.purple,true,0.0),
              orderInfoTile('All Customers',Colors.brown,false,0.0),
            ],
          );
        }
      },
    );
  }

  Widget orderInfoTile(String text,Color boxColor, bool isAmountTitle,double price){

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Container(
        height: 100,
        width: 100,
        child: isAmountTitle?Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Rs ${price}',style:
              TextStyle(fontSize: 18,color: Colors.white,),
                softWrap: true,maxLines: 1,textAlign: TextAlign.center,),
              Text(text,style:
              TextStyle(fontSize: 14,color: Colors.white,),
                softWrap: true,maxLines: 2,textAlign: TextAlign.center,)
            ],
          ),
        ):Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,style:
          TextStyle(fontSize: 14,color: Colors.white,),
            softWrap: true,maxLines: 2,textAlign: TextAlign.center,),
        )),

        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(10.0),
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }

  Widget orderListItems(OrderInfo info){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[

          orderListItemChild01(),
          Expanded(child: orderListItemChild02(info)),
        ],
      ),
    );
  }
  Widget orderListItemChild01(){
    return Container(

      height: 150,
      width: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                width: 60,
                height: 60,
                child: Image.asset('assets/images/demo_img_01.jpg',fit: BoxFit.fill,),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.purple[500],width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
              child: Text('Today',style:
              TextStyle(fontSize: 18,color: Colors.white,),
                softWrap: true,maxLines: 1,textAlign: TextAlign.center,),
            ),
            Text('06:30pm',style:
            TextStyle(fontSize: 18,color: Colors.white,),
              softWrap: true,maxLines: 1,textAlign: TextAlign.center,)
          ],

        ),
      ),
      decoration: BoxDecoration(
        color: Colors.purple,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0)
      ),
    );
  }
  Widget orderListItemChild02(OrderInfo info){

    return Container(
      height: 150,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               Container(

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(info.customer.name,style: TextStyle(color: Colors.black,fontSize: 18,
                        fontWeight:FontWeight.w400 ),),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0, 10, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(child:
                    Image.asset('assets/images/ic_meal.jpg',
                      fit: BoxFit.fill),
                      /*decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.grey,width: 2.0
                          )
                      ),*/
                      width: 30,
                      height: 30,

                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(info.mode,style: TextStyle(color: Colors.black,fontSize: 18,
                    fontWeight:FontWeight.w400 ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(info.payment.mode,style: TextStyle(color: Colors.black,fontSize: 18,
                    fontWeight:FontWeight.w400 ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Rs ${info.payment.amount}',style: TextStyle(color: Colors.black,fontSize: 18,
                    fontWeight:FontWeight.w400 ),),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget orderList({List<OrderInfo> orders}) {

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber,
            child: Center(child: Text('Entry ${index}')),
          );
        }
    );
  }

}
