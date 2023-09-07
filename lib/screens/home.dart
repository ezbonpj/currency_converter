//import 'package:currency_converter/components/usdtoany.dart';
import 'package:currency_converter/components/anytoany.dart';
import 'package:currency_converter/functions/fetchrates.dart';
import 'package:currency_converter/main.dart';
import 'package:currency_converter/models/ratesmodel.dart';
import 'package:flutter/material.dart';
 void main()
 {
  runApp(Home());

 } 

 class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<RatesModel> result;
  late Future<Map> allCurrencies;
  final formkey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    result= fetchrates();
    allCurrencies = fetchcurrencies();
  }
  

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 109, 6, 193),
        title: const Text("Currency Converter"),
        centerTitle: true     ,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         padding: const EdgeInsets.only(top: 65,left: 15,right:15 ),
         decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover, 
            
          )

         ), 
         child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: result,
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting)
              {
              return const Center(
                child: CircularProgressIndicator(),
              );
              }
              return Center(
                child: FutureBuilder<Map>(
                  future: allCurrencies,  
                  builder: (context,currSnapshot){
                if(currSnapshot.connectionState==ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                 return Column(
                        children: [
                         /* UsdToAny(
                              rates: snapshot.data!.rates,
                              currencies: currSnapshot.data!),*/
                          const SizedBox(
                            height: 75,
                          ),
                           AnyToAny(
                              rates: snapshot.data!.rates,
                              currencies: currSnapshot.data!)
                  ],
                );

                  } ,

                ),
              );
              }
              ),
            ),

         ),
         
      ),
    );
  }
}