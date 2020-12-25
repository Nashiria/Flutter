import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:quiz_game/Service/Question.dart';
import 'package:quiz_game/Service/Quiz.dart';
import 'package:quiz_game/Service/QuizJson.dart';
import 'package:flutter/material.dart';
import 'ResultPage.dart';
import 'package:http/http.dart' as http;

int _score = 0;
int currentQuestionId = 0;
List<Question> QuizList;

void main() {
  runApp(QuizPage());
}
Future<bool> Done()async{
  return await true;

}

class QuizPage extends StatefulWidget {
  String category;
  QuizPage({Key key, this.category}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<QuizPage> {
  Quiz _quizer=Quiz();
  Future<void> quizloader;
  @override
  Future Start(List<Question> QuList,Question Currentq){
    String Category=widget.category;

  }
  void initState() {
    super.initState();

    int score=_quizer.score;
    int currentQuestion=_quizer.currentQuestion;
    quizloader=_quizer.CreateList("easy",widget.category,10);
    int Index = 0;


  }

  void refresh() {
    if (_quizer.currentQuestion==9) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultPage(
            score: _quizer.score,
          )));
    }

    setState(() {
      if (_quizer.currentQuestion<9){
      _quizer.currentQuestion++;}

      _quizer.Currentq=_quizer.QuList[_quizer.currentQuestion];
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
            title: Text('Questions ${_quizer.currentQuestion}/10')),
        body:  FutureBuilder<void>(
            future: quizloader,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('${_quizer.Currentq.questionInfo}',
                            style: TextStyle(
                              fontSize: 30,
                            )),
                      ),
                    ),
                    Expanded( child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: OutlineButton(
                              color: Colors.blue,
                              shape: StadiumBorder(),
                              textColor: Colors.blue,
                              child: new Text(_quizer.Currentq.options[0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid,
                                  width: 5),
                              onPressed: () {_quizer.nextQuestino(_quizer.Currentq.correctAns, _quizer.Currentq.options[0]);
                              refresh();

                              },
                            )
                        ),

                      ],
                    )),
                    Expanded( child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: OutlineButton(
                              color: Colors.blue,
                              shape: StadiumBorder(),
                              textColor: Colors.blue,
                              child: new Text(_quizer.Currentq.options[1],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid,
                                  width: 5),
                              onPressed: () {_quizer.nextQuestino(_quizer.Currentq.correctAns, _quizer.Currentq.options[1]);
                              refresh();

                              },
                            )
                        ),

                      ],
                    )),
                    Expanded( child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: OutlineButton(
                              color: Colors.blue,
                              shape: StadiumBorder(),
                              textColor: Colors.blue,
                              child: new Text(_quizer.Currentq.options[2],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid,
                                  width: 5),
                              onPressed: (){_quizer.nextQuestino(_quizer.Currentq.correctAns, _quizer.Currentq.options[2]);
                              refresh();

                              },
                            )
                        ),

                      ],
                    )),
                    Expanded( child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: OutlineButton(
                              color: Colors.blue,
                              shape: StadiumBorder(),
                              textColor: Colors.blue,
                              child: new Text(_quizer.Currentq.options[3],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid,
                                  width: 5),
                              onPressed: (){_quizer.nextQuestino(_quizer.Currentq.correctAns, _quizer.Currentq.options[3]);
                              refresh();

                              },
                            )
                        ),

                      ],
                    )),

                  ],
                );
                // ignore: missing_return
              }else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}