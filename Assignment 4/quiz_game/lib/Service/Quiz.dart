import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:universal_html/html.dart' as html;
import 'Question.dart';

Quiz quizFromJson(String str) => Quiz.fromJson(json.decode(str));

String quizToJson(Quiz data) => json.encode(data.toJson());

class Quiz {

  Quiz({
    this.responseCode,
    this.results,
  });
  int score=0;
  int currentQuestion=0;


  List<Question> QuList;
  Question Currentq;
  Future<Quiz> LoadQuizAssetOnline(String level,String Category,int QuestionNumber)async{
    int cat=0;

    if(Category=="Music"){cat=12;}
    if(Category=="General Knowledge"){cat=9;}
    if(Category=="Movies"){cat=11;}
    String goUrl="https://opentdb.com/api.php?amount="+QuestionNumber.toString()+"&category="+cat.toString()+"&difficulty="+level+"&type=multiple";
    var response = await http.get(goUrl);
    var jsonResponse = jsonDecode(response.body);
    Quiz quizv = Quiz.fromJson( await jsonResponse);
    return quizv;

  }
  String _parseHtmlString(String htmlString) {
    var text = html.Element.span()..appendHtml(htmlString);
    return text.innerText;
  }
  Future<Question> AddQuestion(String level,int QuestionNumber,int Index,String Category) async {
    Quiz currQuiz=await LoadQuizAssetOnline(level, Category, QuestionNumber);
    var  questionInfo= _parseHtmlString(currQuiz.results[Index].question);
    var  option1= _parseHtmlString(currQuiz.results[Index].incorrectAnswers[0]);
    var  option2= _parseHtmlString(currQuiz.results[Index].incorrectAnswers[1]);
    var  option3= _parseHtmlString(currQuiz.results[Index].incorrectAnswers[2]);
    var  option4= _parseHtmlString(currQuiz.results[Index].correctAnswer);
    var  correctAns=option4;
    Question NewQuestion= new Question();
    NewQuestion.index= Index;
    NewQuestion.questionInfo= questionInfo;
    NewQuestion.option1= option1;
    NewQuestion.option2= option2;
    NewQuestion.option3= option3;
    NewQuestion.option4= correctAns;
    NewQuestion.options= [];
    List<String> nx=[];
    NewQuestion.options.add( NewQuestion.option1);
    NewQuestion.options.add( NewQuestion.option2);
    NewQuestion.options.add( NewQuestion.option3);
    NewQuestion.options.add( NewQuestion.correctAns);
    NewQuestion.options.shuffle();
    NewQuestion=await RandomizeOptions(NewQuestion);
    NewQuestion.correctAns= correctAns;
    return  NewQuestion;
  }
  bool CheckAnswer(String Answer,String Pressed) {
    if (Answer.toString() == Pressed.toString()) {
      return true;
    }
    else {
      return false;
    }
  }
  void nextQuestino(String Answer,String Pressed){

    if(CheckAnswer(Answer, Pressed)){
      score+=10;
    }
    Currentq=QuList[currentQuestion];
  }
  Future<int> totalQuestionNumber() async{ 4;}
  Future<String> GetQuestionText(Question currQuestion)async {
    return await currQuestion.questionInfo;   }

  int GetCurrentQuestionId(){return currentQuestion;}
  int GetScore(){return score;}
  Future<Question> RandomizeOptions(Question Questino) async {
    var  option1= Questino.option1;
    var  option2= Questino.option2;
    var  option3= Questino.option3;
    var  option4= Questino.option4;
    List<String> toReturn=[];
    toReturn.add( option1);
    toReturn.add( option2);
    toReturn.add( option3);
    toReturn.add( option4);
    toReturn.shuffle();
    Questino.options=toReturn;
    return await Questino;

  }

  Future<List<Question>>CreateList(String level,String Category,int QuestionNumber) async {
    List<Question> QuestionList=[];
    for (int i=0;i<QuestionNumber;i++){
      QuestionList.add(await AddQuestion(level,QuestionNumber,i,Category));

    }
    QuestionList.shuffle();
    QuList=QuestionList;
    Currentq=QuList[0];
  }
  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }
  int responseCode;
  List<Result> results;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    responseCode: json["response_code"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
  });

  String category;
  Type type;
  Difficulty difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    category: json["category"],
    type: typeValues.map[json["type"]],
    difficulty: difficultyValues.map[json["difficulty"]],
    question: json["question"],
    correctAnswer: json["correct_answer"],
    incorrectAnswers: List<String>.from(json["incorrect_answers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "type": typeValues.reverse[type],
    "difficulty": difficultyValues.reverse[difficulty],
    "question": question,
    "correct_answer": correctAnswer,
    "incorrect_answers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
  };
}

enum Difficulty { EASY, HARD, MEDIUM }

final difficultyValues = EnumValues({
  "easy": Difficulty.EASY,
  "hard": Difficulty.HARD,
  "medium": Difficulty.MEDIUM
});

enum Type { MULTIPLE, BOOLEAN }

final typeValues = EnumValues({
  "boolean": Type.BOOLEAN,
  "multiple": Type.MULTIPLE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
