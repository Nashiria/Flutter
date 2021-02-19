import 'package:flutter/cupertino.dart';
import 'package:predizione/Services/Accuracy.dart';
import 'dart:math';
class weightKey {
  weightKey(
    this.home,
    this.draw,
    this.away,
    this.powerRank,
    this.resultPerc,
    this.pyEx,
    this.pyExSide,
    this.pattern1,
    this.pattern3,
    this.pattern5,
  );
  double home;
  double draw;
  double away;
  double powerRank;
  double resultPerc;
  double pyEx;
  double pyExSide;
  double pattern1;
  double pattern3;
  double pattern5;
    double getRandom(int min, int max){var rng=new Random(); return rng.nextInt(max-min) + min + 0.0;}
    weightKey FixKeyAcc(Accuracy acc) {
    weightKey crKey = acc.key;
    double hk = acc.guessedHomeRatio;
    double dk = acc.guessedDrawRatio;
    double ak = acc.guessedAwayRatio;
    if (hk > dk + 0.1) {
      crKey.draw += (acc.guessedHomeRatio - acc.guessedDrawRatio) * 30.0;
    }
    if (hk > ak + 0.1) {
      crKey.away += (acc.guessedHomeRatio - acc.guessedAwayRatio) * 30.0;
    }
    if (ak > dk + 0.1) {
      crKey.draw += (acc.guessedAwayRatio - acc.guessedDrawRatio) * 30.0;
    }
    if (ak > hk + 0.1) {
      crKey.home += acc.guessedAwayRatio / acc.guessedHomeRatio * 30.0;
    }
    if (dk > ak + 0.1) {
      crKey.away += (acc.guessedDrawRatio - acc.guessedAwayRatio) * 30.0;
    }
    if (dk > hk + 0.1) {
      crKey.home += acc.guessedDrawRatio / acc.guessedHomeRatio * 30.0;
    }
    acc.key = crKey;
    return crKey;
  }
  weightKey randomKey() {
    weightKey toReturn = new weightKey(0,0,0,0,0,0,0,0,0,0);
    toReturn.home = 100.0;
    toReturn.draw = 100.0;
    toReturn.away = 100.0;
    toReturn.powerRank = getRandom(-1000, 1000)/100;
    toReturn.resultPerc = getRandom(-1000, 1000)/100;
    toReturn.pyEx = getRandom(-1000, 1000)/100;
    toReturn.pyExSide = getRandom(-1000, 1000)/100;
    toReturn.pattern1 = 0.0;
    toReturn.pattern3 = 0.0;
    toReturn.pattern5 = 0.0;
    return toReturn;
  }
}