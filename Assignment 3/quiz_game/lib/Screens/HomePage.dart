import 'package:quiz_game/Screens/MathPage.dart';
import 'package:quiz_game/Screens/CapitalPage.dart';
import 'package:flutter/material.dart';

void gotoQuizPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => MathPage()),
  );
}
void gotoQuizPage2(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => CapitalPage()),
  );
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quizes')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                'Please choose a category.',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          RaisedButton(
            onPressed: () {
              gotoQuizPage(context);
            },
            child: Text('Math'),
          ),SizedBox(
            height: 60,
          ),
          RaisedButton(
            onPressed: () {
              gotoQuizPage2(context);
            },
            child: Text('Capitals'),
          )
        ],
      ),
    );
  }
}