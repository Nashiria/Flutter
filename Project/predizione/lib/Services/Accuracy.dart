import 'dart:math';

import 'package:predizione/Services/weightKey.dart';

class Accuracy {
  Accuracy(
    this.league,
    this.Season,
    this.resultRatio,
    this.accuracyScore,
    this.correctHomeGoal,
    this.correctAwayGoal,
    this.correctResult,
    this.wrongHomeGoal,
    this.wrongResult,
    this.wrongAwayGoal,
    this.totalMatch,
    this.homeGoalRatio,
    this.awayGoalRatio,
    this.guessedDraw,
    this.guessedHome,
    this.guessedAway,
    this.correctHome,
    this.correctDraw,
    this.correctAway,
    this.wrongHome,
    this.wrongDraw,
    this.wrongAway,
    this.homeRatio,
    this.drawRatio,
    this.awayRatio,
    this.guessedHomeRatio,
    this.guessedDrawRatio,
    this.guessedAwayRatio,
    this.key
  );
  String league;
  int Season;
  int correctHomeGoal=0;
  int correctAwayGoal=0;
  int correctResult=0;
  int wrongAwayGoal=0;
  int wrongHomeGoal=0;
  int wrongResult=0;
  int totalMatch=0;
  double homeGoalRatio=0;
  double resultRatio=0;
  double awayGoalRatio=0;
  double accuracyScore=0;
  int guessedDraw=0;
  int guessedHome=0;
  int guessedAway=0;
  int correctDraw=0;
  int correctAway=0;
  int correctHome=0;
  int wrongAway=0;
  int wrongHome=0;
  int wrongDraw=0;
  double drawRatio=0;
  double homeRatio=0;
  double awayRatio=0;
  double guessedDrawRatio=0;
  double guessedHomeRatio=0;
  double guessedAwayRatio=0;
  weightKey key;
  double getRandom(int min, int max){var rng=new Random(); return rng.nextInt(max-min) + min + 0.0;}
  weightKey randomKey() {
    weightKey toReturn = new weightKey(0,0,0,0,0,0,0,0,0,0);
    toReturn.home = 100;
    toReturn.draw = 100;
    toReturn.away = 100;
    toReturn.powerRank = getRandom(-10,10).toDouble();
    toReturn.resultPerc = getRandom(-10,10).toDouble();
    toReturn.pyEx = getRandom(-10,10).toDouble();
    toReturn.pyExSide = 0;
    toReturn.pattern1 =  0;
    toReturn.pattern3 = 0;
    toReturn.pattern5 =  0;
    return toReturn;}
  Accuracy newAcc(){
    Accuracy acc=new Accuracy("",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,randomKey());
    return acc;
  }
}
