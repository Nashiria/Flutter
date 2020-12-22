class Question {
  int index;
   String  questionInfo;
 String  questionType;
 String  option1;
 String  option2;
 String  option3;
 String  option4;
 List<String> options;
 String  correctAns;
Question({
  this.index,
  this.questionInfo,
  this.questionType,
  this.options,
  this.option1,
  this.option2,
  this.option3,
  this.option4,
  this.correctAns
});
factory Question.fromJson(Map<String, dynamic> json){
return Question(

questionInfo:json['questionInfo'].toString(),
questionType:json['questionType'].toString(),
option1:json['option1'].toString(),
option2:json['option2'].toString(),
option3:json['option3'].toString(),
option4:json['option4'].toString(),
correctAns:json['correctAns'].toString()
);
}
}
