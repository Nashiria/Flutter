
class QuizJson {
  var index;
  var  questionInfo;
  var  questionType;
  var  option1;
  var option2;
  var  option3;
  var  option4;
  var  correctAns;
  QuizJson({
    this.index,
    this.questionInfo,
    this.questionType,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.correctAns
  });
  factory QuizJson.fromJson(Map<String, dynamic> json){
    return QuizJson(

        questionInfo:json['questionInfo'],
        questionType:json['questionType'],
        option1:json['option1'],
        option2:json['option2'],
        option3:json['option3'],
        option4:json['option4'],
        correctAns:json['correctAns'],
    );
  }
}
