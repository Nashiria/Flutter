import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:quiz_game/Screens/MathPage.dart';
import 'package:quiz_game/Service/Question.dart';
import 'package:quiz_game/Service/QuizJson.dart';
import 'package:flutter/material.dart';
import 'ResultPage.dart';


  Future<String> _LoadQuizAsset(String Directory) async {

    return await rootBundle.loadString(Directory);
  }

Future _loadJson(String Directory) async {

  Map userMap = jsonDecode(await _LoadQuizAsset(Directory));
  QuizJson currQuestion = QuizJson.fromJson(userMap);
  return await currQuestion;

}

Future<Question> AddQuestion2(String Directory) async {

  random(min, max){
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }
  int Index=random(0, 500);
  QuizJson currQuestion=await _loadJson(Directory);
  var  questionInfo=await currQuestion.questionInfo[Index];
  var  questionType=await currQuestion.questionType[Index];
  var  option1=await currQuestion.option1[Index];
  var  option2=await currQuestion.option2[Index];
  var  option3=await currQuestion.option3[Index];
  var  option4=await currQuestion.option4[Index];
  var  correctAns=await currQuestion.correctAns[Index];
  Question NewQuestion=await new Question();
  NewQuestion.index=await Index;
  NewQuestion.questionInfo=await questionInfo;
  NewQuestion.questionType=await questionType;
  NewQuestion.option1=await option1;
  NewQuestion.option2=await option2;
  NewQuestion.option3=await option3;
  NewQuestion.option4=await correctAns;
  NewQuestion.options=await [];
  List<String> nx=[];

  NewQuestion.options.add(await NewQuestion.option1);
  NewQuestion.options.add(await NewQuestion.option2);
  NewQuestion.options.add(await NewQuestion.option3);
  NewQuestion.options.add(await NewQuestion.correctAns);
  NewQuestion.options.shuffle();
  NewQuestion=await RandomizeOptions(NewQuestion);
  NewQuestion.correctAns=await correctAns;
  return await NewQuestion;
}


  Future<List<Question>>CreateList(String Directory) async {
    List<Question> QuestionList=[];
    QuestionList.add(await AddQuestion2(Directory));
    QuestionList.add(await AddQuestion2(Directory));
    QuestionList.add(await AddQuestion2(Directory));
    QuestionList.add(await AddQuestion2(Directory));
    QuestionList.add(await AddQuestion2(Directory));
    QuestionList.add(await AddQuestion2(Directory));
    QuestionList.add(await AddQuestion2(Directory));
    QuestionList.add(await AddQuestion2(Directory));
    QuestionList.add(await AddQuestion2(Directory));
    QuestionList.add(await AddQuestion2(Directory));
    QuestionList.shuffle();
    return await QuestionList;
  }
  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }
  int _score = 0;
  int currentQuestionId = 0;
  List<Question> QuizList;
  bool isFinished() =>  currentQuestionId >= 4;
  int getTotalScore() => _score;
  int getCurrentId() => currentQuestionId + 1;
  Future<int> totalQuestionNumber() async{ 4;}
  Future StartQuiz(String Directory)async {
    QuizList=await CreateList(Directory);   }
  Future<String> GetQuestionText(Question currQuestion)async {
    return await currQuestion.questionInfo;   }
  Future<Question> GetCurrentQuestion()async {
    if(currentQuestionId<4){
      return await QuizList[currentQuestionId];

    }
    else{
      return await QuizList[currentQuestionId-1];
    }}
  Future nextQuestion(score) async {
    if (currentQuestionId < await 4) {
      _score += score;
      currentQuestionId++;
    }
    print(currentQuestionId);
  }


Future<Question> RandomizeOptions(Question Questino) async {
  var  option1=await Questino.option1;
  var  option2=await Questino.option2;
  var  option3=await Questino.option3;
  var  option4=await Questino.option4;
  List<String> toReturn=[];
  toReturn.add(await option1);
  toReturn.add(await option2);
  toReturn.add(await option3);
  toReturn.add(await option4);
  toReturn.shuffle();
  Questino.options=toReturn;
  return await Questino;

  }

void main() {
  runApp(MathPage());
}

class MathPage extends StatefulWidget {
  MathPage();
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MathPage> {
  int score=0;
  int currentQuestion=0;
  List<Question> QuList;
  Question Currentq;
  bool _loaded = false;
  @override
  void initState() {
    super.initState();
    String MathDir = ("assets/math.json");
    String Parameter = "questionInfo";
    int score=0;
    var QuestionX;
    int Index = 0;
    _loadJson(MathDir).then((s) => setState(() {
      QuestionX = s;
      _loaded = true;
    }));
    ;CreateList(MathDir).then((s) => setState(() {
      QuList = s;
      _loaded = true;
      Currentq=QuList[0];
    }));


  }
  bool CheckAnswer(String Answer,String Pressed) {
    if (Answer.toString() == Pressed.toString()) {
      return true;
    }
    else {
      return false;
    }
  }
  void refresh() {
    if (currentQuestion==9) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultPage(
            score: score,
          )));
    }
    print(score);
    setState(() {
      currentQuestion++;

      Currentq=QuList[currentQuestion];
      print(Currentq.correctAns);
    });
  }
  void nextQuestino(String Answer,String Pressed){

    if(CheckAnswer(Answer, Pressed)){
      score+=10;
    }
    Currentq=QuList[currentQuestion];
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
        title: Text('Questions ${currentQuestion}/10')),
      body: Center(

        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Text('${Currentq.questionInfo}',
                    style: TextStyle(
                      fontSize: 40,
                    )),
              ),
            ),
            Expanded(  child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: OutlineButton(
                      color: Colors.blue,
                      shape: StadiumBorder(),
                      textColor: Colors.blue,
                      child: new Text(Currentq.options[0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                      borderSide: BorderSide(
                          color: Colors.blue, style: BorderStyle.solid,
                          width: 5),
                      onPressed: () {nextQuestino(Currentq.correctAns, Currentq.options[0]);
                      refresh();

                      },
                    )
                ),

              ],
                )),
            Expanded(  child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: OutlineButton(
                      color: Colors.blue,
                      shape: StadiumBorder(),
                      textColor: Colors.blue,
                      child: new Text(Currentq.options[1],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                      borderSide: BorderSide(
                          color: Colors.blue, style: BorderStyle.solid,
                          width: 5),
                      onPressed: () {nextQuestino(Currentq.correctAns, Currentq.options[1]);
                      refresh();

                      },
                    )
                ),

              ],
                )),
            Expanded(   child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: OutlineButton(
                      color: Colors.blue,
                      shape: StadiumBorder(),
                      textColor: Colors.blue,
                      child: new Text(Currentq.options[2],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                      borderSide: BorderSide(
                          color: Colors.blue, style: BorderStyle.solid,
                          width: 5),
                      onPressed: (){nextQuestino(Currentq.correctAns, Currentq.options[2]);
                      refresh();

                      },
                    )
                ),

              ],
            )),
            Expanded(  child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: OutlineButton(
                color: Colors.blue,
                shape: StadiumBorder(),
                textColor: Colors.blue,
                 child: new Text(Currentq.options[3],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                  borderSide: BorderSide(
                    color: Colors.blue, style: BorderStyle.solid,
                    width: 5),
                onPressed: (){nextQuestino(Currentq.correctAns, Currentq.options[3]);
                refresh();

                },
            )
                  ),

              ],
            )),

          ],
        ),
      ),
    );
  }
}