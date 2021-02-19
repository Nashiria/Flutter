import 'package:flutter/material.dart';
import 'package:predizione/Services/weightKey.dart';
import 'Screens/MainScreen.dart';
import 'Services/Prediction.dart';
import 'Services/database.dart';
void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    Prediction pd=new Prediction();
    database db=new database();
    pd=database().loadDatabase();
    pd.key=pd.findMaxAcc("Mahalle Ligi", 2020).key;
    return MaterialApp(

          routes: {
            MainScreen.routeName: (context) => MainScreen(),
          },

      home: Builder(

        builder: (context) => Center(
          child:
            RaisedButton(
                child: Text("Start"),
                onPressed: () {
                  pd=database().matchList(pd,  "aaaa");
                  pd.findBetterKey();
                  Navigator.pushNamed(context, MainScreen.routeName,arguments: pd);
                } )))







    );

  }
}