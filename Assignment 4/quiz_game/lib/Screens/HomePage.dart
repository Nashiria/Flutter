import 'package:quiz_game/Screens/QuizPage.dart';
import 'package:flutter/material.dart';

void gotoQuizPage(String Category,BuildContext context) {

  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => QuizPage(
        category: Category,
      )));
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
              gotoQuizPage("Music",context);
            },
            child: Text('Music'),
          ),SizedBox(
            height: 60,
          ),RaisedButton(
            onPressed: () {
              gotoQuizPage("Movies",context);
            },
            child: Text('Movies'),
          ),SizedBox(
            height: 60,
          ),
          RaisedButton(
            onPressed: () {
              gotoQuizPage("General Knowledge",context);
            },
            child: Text('General Knowledge'),
          )
        ],
      ),
    );
  }
}