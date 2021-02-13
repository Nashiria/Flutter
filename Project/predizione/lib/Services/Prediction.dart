

import 'package:predizione/Services/database.dart';

import 'Accuracy.dart';
import 'League.dart';
import 'Odd.dart';
import 'Team.dart';
import 'Match.dart';
import 'weightKey.dart';
import 'dart:math';


class Prediction {
  List<String> homeForms;
  List<String> totalForms;
  List<String> awayForms;
  List<Odd> betOdds;
  List<Match> Matches;
  List<Accuracy> Keylist;
  String strtotalform="";
  League CurrentLeague;
  weightKey key;
  bool showodd=false;
  bool teamnameindeciderates=false;
  bool showodds=false;
  bool showprediction=false;
  bool patterns=false;
  List<String> LeagueNames;
  Team getTeam(String teamName){
    Team toReturn=new Team();
    for(int i=0;i<CurrentLeague.Teams.length;i++)
    {
      if(CurrentLeague.Teams[i].teamName == teamName){
        toReturn=CurrentLeague.Teams[i];}
    }
    return toReturn;
  }
  Odd PythagoreanExpectation(Team hometeam, Team awayteam) {

    double hometeamt = pow(hometeam.totalGoals, 1.22777) / ( pow(hometeam.totalGoals, 1.0723880529403687) +  pow(hometeam.totalConcede, 1.1272480487823486)) * 2.4999730587005615 * hometeam.totalMatch;
    double awayteamt = pow(awayteam.totalGoals, 1.22777) / ( pow(awayteam.totalGoals, 1.0723880529403687) + pow(awayteam.totalConcede, 1.1272480487823486)) * 2.4999730587005615 * awayteam.totalMatch;
    double total = hometeamt + awayteamt;
    double htr = hometeamt / total;
    double atr = awayteamt / total;
    Odd toReturn = new Odd(0,0);
    toReturn.hw = htr;
    toReturn.aw = atr;
    return toReturn;
  }
  Odd PythagoreanExpectationWithSides(Team hometeam, Team awayteam) {
    double hometeamt = pow(hometeam.homeGoals, 1.22777) / ( pow(hometeam.homeGoals, 1.0723880529403687) +  pow(hometeam.homeConcede, 1.1272480487823486)) * 2.4999730587005615 * hometeam.homeMatch;
    double awayteamt = pow(awayteam.awayGoals, 1.22777) / ( pow(awayteam.awayGoals, 1.0723880529403687) + pow(awayteam.awayConcede, 1.1272480487823486)) * 2.4999730587005615 * awayteam.awayMatch;
    double total = hometeamt + awayteamt;
    double htr = hometeamt / total;
    double atr = awayteamt / total;
    Odd toReturn = new Odd(0,0);
    toReturn.hw = htr;
    toReturn.aw = atr;
    return toReturn;
  }
  Odd PowerRank(Team hometeam, Team awayteam) {
    double probofelo1win = 1.0 / pow(10.0, (awayteam.elo - hometeam.elo) / 400.0) / 2.0;
    double probofelo2win = 1.0 / pow(10.0, (hometeam.elo - awayteam.elo) / 400.0) / 2.0;
    double draw = (probofelo1win - probofelo2win).abs();
    double formula = (2.0 * pow(draw, 2.0) / 75.0 - 47.0 * draw / 30.0 + 33.0) / 100.0;
    double total = probofelo1win + probofelo2win;
    probofelo1win /= total;
    probofelo2win /= total;
    if (probofelo1win < 0.0) {
      probofelo1win = -probofelo1win;
      probofelo2win += 2.0 * probofelo1win;
    }
    if (probofelo2win < 0.0) {
      probofelo2win = -probofelo2win;
      probofelo1win += probofelo2win;
    }
    Odd currentOdd = new Odd(0,0);
    currentOdd.hw = probofelo1win;
    currentOdd.aw = probofelo2win;
    return currentOdd;
  }
  Odd calculateResultPerc(League currentLeague, Team team1, Team team2) {
    int hometeam_HomeGoals = team1.homeGoals;
    int hometeam_HomeMatches = team1.homeMatch;
    int awayteam_AwayMatches = team2.awayMatch;
    int awayteam_AwayGoals = team2.awayGoals;
    int hometeam_HomeConceded = team1.homeConcede;
    int awayteam_AwayConceded = team2.awayConcede;
    int league_AwayConceded = currentLeague.homeScored;
    int league_HomeConceded = currentLeague.awayScored;
    int league_HomeGoals = currentLeague.homeScored;
    int league_AwayGoals = currentLeague.awayScored;
    int league_TotalMatch = currentLeague.totalMatch;
    if (hometeam_HomeGoals == 0) {hometeam_HomeGoals = 1;}
    if (hometeam_HomeMatches == 0) {hometeam_HomeMatches = 1;}
    if (awayteam_AwayMatches == 0) {awayteam_AwayMatches = 1;}
    if (awayteam_AwayGoals == 0) {awayteam_AwayGoals = 1;}
    if (hometeam_HomeConceded == 0) {hometeam_HomeConceded = 1;}
    if (awayteam_AwayConceded == 0) {awayteam_AwayConceded = 1;}
    if (league_AwayConceded == 0) {league_AwayConceded = 1;}
    if (league_HomeConceded == 0) {league_HomeConceded = 1;}
    if (league_HomeGoals == 0) {league_HomeGoals = 1;}
    if (league_AwayGoals == 0) {league_AwayGoals = 1;}
    if (league_TotalMatch == 0) {league_TotalMatch = 1;}
    double hometeam_AttackStrenght = (hometeam_HomeGoals / hometeam_HomeMatches) * (league_HomeGoals / league_TotalMatch);
    double awayteam_AttackStrenght = (awayteam_AwayGoals / awayteam_AwayMatches) * (league_AwayGoals / league_TotalMatch);
    double hometeam_DefenseStrength = (hometeam_HomeConceded / hometeam_HomeMatches) * (league_HomeConceded / league_TotalMatch);
    double awayteam_DefenseStrength = (awayteam_AwayConceded / awayteam_AwayMatches) * (league_AwayConceded / league_TotalMatch);
    if (awayteam_AwayConceded == 0) {awayteam_DefenseStrength = 2.0;}
    if (hometeam_HomeConceded == 0) {hometeam_DefenseStrength = 2.0;}
    double hometeam_PossibleGoals = hometeam_AttackStrenght / awayteam_DefenseStrength * (league_HomeGoals / league_TotalMatch);
    double awayteam_PossibleGoals = awayteam_AttackStrenght / hometeam_DefenseStrength * (league_AwayGoals / league_TotalMatch);
    Odd toReturn = new Odd(0,0);
    toReturn.hw = (10000.0 * awayteam_PossibleGoals / (hometeam_PossibleGoals + awayteam_PossibleGoals) / 10000.0).round().toDouble();
    toReturn.aw = (10000.0 * awayteam_PossibleGoals / (hometeam_PossibleGoals + awayteam_PossibleGoals) / 10000.0).round().toDouble();
    return toReturn;
  }
  Odd PatternFind(List<String> PatternList,String homeForm,String awayForm,weightKey currKey){
    Odd toReturn=new Odd(0,0);
    if((homeForm==null)==false&&(awayForm==null)==false&&homeForm.isEmpty==false && awayForm.isEmpty==false){
      String home1=LastNCharacters(homeForm, 1);
      String home3=LastNCharacters(homeForm, 3);
      String home5=LastNCharacters(homeForm, 5);
      String away1=LastNCharacters(awayForm, 1);
      String away3=LastNCharacters(awayForm, 3);
      String away5=LastNCharacters(awayForm, 5);
      double h1matchedW=0;
      double h1matchedD=0;
      double h1matchedL=0;
      double h3matchedW=0;
      double h3matchedD=0;
      double h3matchedL=0;
      double h5matchedW=0;
      double h5matchedD=0;
      double h5matchedL=0;
      double a1matchedW=0;
      double a1matchedD=0;
      double a1matchedL=0;
      double a3matchedW=0;
      double a3matchedD=0;
      double a3matchedL=0;
      double a5matchedW=0;
      double a5matchedD=0;
      double a5matchedL=0;
      if(strtotalform==""){
        for(int i=0;i<PatternList.length;i++)
        {   strtotalform+=PatternList[i];
        }
      }
      h1matchedW=count(strtotalform, home1+"W").toDouble();
      h1matchedD=count(strtotalform, home1+"D").toDouble();
      h1matchedL=count(strtotalform, home1+"L").toDouble();
      h3matchedW=count(strtotalform, home3+"W").toDouble();
      h3matchedD=count(strtotalform, home3+"D").toDouble();
      h3matchedL=count(strtotalform, home3+"L").toDouble();
      h5matchedW=count(strtotalform, home5+"W").toDouble();
      h5matchedD=count(strtotalform, home5+"D").toDouble();
      h5matchedL=count(strtotalform, home5+"L").toDouble();
      a1matchedW=count(strtotalform, away1+"W").toDouble();
      a1matchedD=count(strtotalform, away1+"D").toDouble();
      a1matchedL=count(strtotalform, away1+"L").toDouble();
      a3matchedW=count(strtotalform, away3+"W").toDouble();
      a3matchedD=count(strtotalform, away3+"D").toDouble();
      a3matchedL=count(strtotalform, away3+"L").toDouble();
      a5matchedW=count(strtotalform, away5+"W").toDouble();
      a5matchedD=count(strtotalform, away5+"D").toDouble();
      a5matchedL=count(strtotalform, away5+"L").toDouble();
      h1matchedW*=currKey.pattern1;
      h1matchedD*=currKey.pattern1;
      h1matchedL*=currKey.pattern1;
      h3matchedW*=currKey.pattern3;
      h3matchedD*=currKey.pattern3;
      h3matchedL*=currKey.pattern3;
      h5matchedW*=currKey.pattern5;
      h5matchedD*=currKey.pattern5;
      h5matchedL*=currKey.pattern5;
      a1matchedW*=currKey.pattern1;
      a1matchedD*=currKey.pattern1;
      a1matchedL*=currKey.pattern1;
      a3matchedW*=currKey.pattern3;
      a3matchedD*=currKey.pattern3;
      a3matchedL*=currKey.pattern3;
      a5matchedW*=currKey.pattern5;
      a5matchedD*=currKey.pattern5;
      a5matchedL*=currKey.pattern5;
      toReturn.hw=h1matchedW+h3matchedW+h5matchedW+a1matchedL+a3matchedL+a5matchedL;
      toReturn.aw=a1matchedW+a3matchedW+a5matchedW+h1matchedL+h3matchedL+h5matchedL;
      double total=0;

      if(patterns){  print(perc(toReturn.hw/(toReturn.hw+toReturn.aw)).toString()+" "+perc(toReturn.aw/(toReturn.hw+toReturn.aw)).toString());}
      return toReturn;
    }
    else{toReturn.hw=0.60*(currKey.pattern1*currKey.pattern3*currKey.pattern5);toReturn.aw=0.40*(currKey.pattern1*currKey.pattern3*currKey.pattern5);return toReturn;}
  }
  String LastNCharacters(String input,int n){
    String copy=input;
    if (copy.length > n)
    {
      copy = copy.substring(input.length - n);
    }
    else
    {
      copy = input;
    }

    return copy;
  }
  static int count(String str, String target) {return ((str.length - str.replaceAll(target, "").length) / target.length).toInt();}
  static int getRandom(int min, int max){return  (new Random().nextInt(max - min) + min).toInt();}
  static int poisson(double mean) {int r = 0;Random ran = new Random();double a = ran.nextDouble();double p = exp(-mean);while (a > p) {r++;a = a - p;p = p * mean / r;}return r;}
  Match AddOdd(Match m, Odd o,double d){
    if(m.machineWinHome==null){m.machineWinHome=0;}if(m.machineWinAway==null){m.machineWinAway=0;}
    m.machineWinHome+=o.hw*d;m.machineWinAway+=o.aw*d;return m;}
  Match decideRates(Match m,weightKey key){
    m.machineAwayRatio=0;
    m.machineHomeRatio=0;
    m.machineDrawRatio=0;
    if(getTeam(m.homeTeam).totalMatch>0 && getTeam(m.awayTeam).totalMatch>0){
      if(getTeam(m.homeTeam).totalGoals>0 && getTeam(m.awayTeam).totalGoals>0 && getTeam(m.homeTeam).totalConcede>0 && getTeam(m.awayTeam).totalConcede>0){
        if(getTeam(m.homeTeam).homeGoals>0 && getTeam(m.awayTeam).homeConcede>0 && getTeam(m.homeTeam).awayConcede>0 && getTeam(m.awayTeam).awayGoals>0){
          // m=AddOdd(m,PythagoreanExpectationWithSides(getTeam(m.homeTeam), getTeam(m.awayTeam)),key.pyExSide);

        }
        m=AddOdd(m,PythagoreanExpectation(getTeam(m.homeTeam), getTeam(m.awayTeam)),key.pyEx);
        m=AddOdd(m,calculateResultPerc(CurrentLeague,getTeam(m.homeTeam), getTeam(m.awayTeam)),key.resultPerc);
      }
// m=AddOdd(m,PatternFind(totalForms, getTeam(m.homeTeam).form, getTeam(m.awayTeam).form, key),1d);
    }
    if(teamnameindeciderates){print(getTeam(m.homeTeam).elo);}
    m=AddOdd(m,PowerRank(getTeam(m.homeTeam), getTeam(m.awayTeam)),key.powerRank);
    m=fillOdd(betOdds, m);
    if(showodds){   print(m.machineHomeRatio.toString()+" "+m.machineDrawRatio.toString()+" "+m.machineAwayRatio.toString());}
    return m;
  }
  double GenerateDraw(List<Odd> betOdds, Match m) {
    int numberOfOccurencies = 0;
    double Total = 0.0;
    m.machineWinHome=(m.machineWinHome).abs();
    m.machineWinAway=(m.machineWinAway).abs();
    double total=(m.machineWinHome).abs()+(m.machineWinAway).abs();
    m.machineWinHome=m.machineWinHome/total;
    m.machineWinAway=m.machineWinAway/total;
    for(int i = 0; i < betOdds.length; ++i) {
      if(m.machineWinAway==null){m.machineWinAway=0;}if(m.machineWinHome==null){m.machineWinHome=0;}

      if (m.machineWinHome - 0.02 <= (betOdds[i]).hw && m.machineWinHome + 0.02 >= (betOdds[i]).hw) {
        ++numberOfOccurencies;
        Total = (Total + (betOdds[i].draw).toDouble());
      }
    }
    return 0.1 + Total / numberOfOccurencies;
  }
  Match fillOdd(List<Odd> betOdds, Match odd) {
    odd.machineDrawRatio = GenerateDraw(betOdds, odd);
    double total = 1.0 - odd.machineDrawRatio;
    odd.machineHomeRatio = odd.machineWinHome * (1.0 - odd.machineDrawRatio);
    odd.machineAwayRatio = odd.machineWinAway * (1.0 - odd.machineDrawRatio);
    if(showodd){print(odd.machineHomeRatio.toString()+" "+odd.machineDrawRatio.toString()+" "+odd.machineAwayRatio.toString());}//
    return odd;
  }
  Match decideScore(Match m){
    Team team1=getTeam(m.homeTeam);
    Team team2=getTeam(m.awayTeam);
    double hometeam_HomeGoals = team1.totalGoals.toDouble();
    double hometeam_HomeMatches = team1.totalMatch.toDouble();
    double awayteam_AwayMatches = team2.totalMatch.toDouble();
    double awayteam_AwayGoals = team2.totalGoals.toDouble();
    double hometeam_HomeConceded = team1.totalConcede.toDouble();
    double awayteam_AwayConceded = team2.totalConcede.toDouble();
    if (hometeam_HomeGoals == 0){ hometeam_HomeGoals = 1;}
    if (hometeam_HomeMatches == 0){ hometeam_HomeMatches = 1;}
    if (awayteam_AwayMatches == 0){awayteam_AwayMatches = 1;}
    if (awayteam_AwayGoals == 0){awayteam_AwayGoals = 1;}
    if (hometeam_HomeConceded == 0){hometeam_HomeConceded = 1;}
    if (awayteam_AwayConceded == 0){awayteam_AwayConceded = 1;}
    double hometeam_AttackStrenght = (hometeam_HomeGoals / hometeam_HomeMatches) ;
    double awayteam_AttackStrenght = (awayteam_AwayGoals / awayteam_AwayMatches) ;
    double hometeam_DefenseStrength = (hometeam_HomeConceded / hometeam_HomeMatches) ;
    double awayteam_DefenseStrength = (awayteam_AwayConceded / awayteam_AwayMatches);
    if(awayteam_AwayConceded == 0){awayteam_DefenseStrength = 2;}
    if(hometeam_HomeConceded == 0){hometeam_DefenseStrength = 2;}
    double hometeam_PossibleGoals = (hometeam_AttackStrenght / awayteam_DefenseStrength);
    double awayteam_PossibleGoals = (awayteam_AttackStrenght / hometeam_DefenseStrength);
    //print("hometeam_AttackStrenght "+hometeam_AttackStrenght+" = ( "+hometeam_HomeGoals+" / "+ hometeam_HomeMatches+ " ) * ( "+league_HomeGoals+" / "+league_TotalMatch+" ) ");
    int expectedGoals1=0;
    int expectedGoals2=0;
    int trys=50;
    if(((m.result==Result.EMPTY) && (m.machinePredict==Result.H))||(m.result==Result.H)){
      while(expectedGoals1<=expectedGoals2){
        expectedGoals2=poisson(awayteam_PossibleGoals);
        expectedGoals1=poisson(hometeam_PossibleGoals);
        trys-=1;
        if(trys<0){
          expectedGoals2=poisson(hometeam_PossibleGoals);
          expectedGoals1=expectedGoals2+1;
        }
      }}
    if(((m.result==Result.EMPTY) && (m.machinePredict==Result.D))||(m.result==Result.D)){
      expectedGoals1=poisson((hometeam_PossibleGoals+awayteam_PossibleGoals)/2);
      expectedGoals2=expectedGoals1;
    }
    if(((m.result==Result.EMPTY) && (m.machinePredict==Result.A))||(m.result==Result.A)){
      while(expectedGoals1>=expectedGoals2){
        expectedGoals2=poisson(awayteam_PossibleGoals);
        expectedGoals1=poisson(hometeam_PossibleGoals);
        trys-=1;
        if(trys<0){
          expectedGoals1=poisson(hometeam_PossibleGoals);
          expectedGoals2=expectedGoals1+1;
        }
      }}

    m.machineHomeScore=expectedGoals1;
    m.machineAwayScore=expectedGoals2;
    m.machineGoalCount=m.machineHomeScore+m.machineAwayScore;
    if(m.result!=Result.EMPTY){m.GoalCount=m.homeScore+m.awayScore;m.CorrectGoalCount=m.machineGoalCount==m.GoalCount;}
    m.CorrectResult=m.result==m.machinePredict;
    m.CorrectHomeScore=(m.homeScore==m.machineHomeScore);
    m.CorrectAwayScore=(m.awayScore==m.machineAwayScore);
    return m;

  }
  Match decideResult(Match m,weightKey k){
    double hProb=m.machineHomeRatio*k.home;
    double dProb=m.machineDrawRatio*k.draw;
    double aProb=m.machineAwayRatio*k.away;
    if(hProb>dProb && hProb>aProb){m.machinePredict=Result.H;}
    if(dProb>hProb && dProb>aProb){m.machinePredict=Result.D;}
    if(aProb>dProb && aProb>hProb){m.machinePredict=Result.A;}
    return m;
  }
  Match predictMatch(Match m,weightKey key){

    m=decideRates(m, key);
    m=decideResult(m, key);
    m=decideScore(m);
    if(showprediction){print(m.machinePredict);}
    return m;
  }
  Accuracy giveAccuracy(League league, weightKey key) {
    Accuracy currentAccuracy=new Accuracy("",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,randomKey()).newAcc();

    for(int i = 0; i < league.Results.length; ++i) {
      Match curr = league.Results[i];
      if (curr.result!=Result.EMPTY && curr.machinePredict!=Result.EMPTY) {
        curr.CorrectResult = curr.machinePredict==curr.result;
        if (curr.machinePredict==Result.D) {
          ++currentAccuracy.guessedDraw;
        }

        if (curr.machinePredict==Result.H) {
          ++currentAccuracy.guessedHome;
        }

        if (curr.machinePredict==Result.A) {
          ++currentAccuracy.guessedAway;
        }

        if (curr.CorrectAwayScore) {
          ++currentAccuracy.correctAwayGoal;
        } else {
          ++currentAccuracy.wrongAwayGoal;
        }

        if (curr.CorrectHomeScore) {
          ++currentAccuracy.correctHomeGoal;
        } else {
          ++currentAccuracy.wrongHomeGoal;
        }

        if (curr.CorrectResult) {
          if (curr.result==Result.D) {
            ++currentAccuracy.correctDraw;
          }

          if (curr.result==Result.H) {
            ++currentAccuracy.correctHome;
          }

          if (curr.result==Result.A) {
            ++currentAccuracy.correctAway;
          }

          ++currentAccuracy.correctResult;
        } else {
          ++currentAccuracy.wrongResult;
          if (curr.result==Result.D) {
            ++currentAccuracy.wrongDraw;
          }

          if (curr.result==Result.H) {
            ++currentAccuracy.wrongHome;
          }

          if (curr.result==Result.A) {
            ++currentAccuracy.wrongAway;
          }
        }
      }
    }
    currentAccuracy.totalMatch = currentAccuracy.correctResult + currentAccuracy.wrongResult;
    currentAccuracy.homeGoalRatio = currentAccuracy.correctHomeGoal / currentAccuracy.totalMatch;
    currentAccuracy.awayGoalRatio = currentAccuracy.correctAwayGoal / currentAccuracy.totalMatch;
    currentAccuracy.resultRatio = currentAccuracy.correctResult / currentAccuracy.totalMatch;
    currentAccuracy.homeRatio = currentAccuracy.correctHome / (currentAccuracy.correctHome + currentAccuracy.wrongHome);
    currentAccuracy.drawRatio = currentAccuracy.correctDraw / (currentAccuracy.correctDraw + currentAccuracy.wrongDraw);
    currentAccuracy.awayRatio = currentAccuracy.correctAway / (currentAccuracy.correctAway + currentAccuracy.wrongAway);
    currentAccuracy.guessedAwayRatio = currentAccuracy.guessedAway / currentAccuracy.totalMatch;
    currentAccuracy.guessedDrawRatio = currentAccuracy.guessedDraw / currentAccuracy.totalMatch;
    currentAccuracy.guessedHomeRatio = currentAccuracy.guessedHome / currentAccuracy.totalMatch;
    currentAccuracy.accuracyScore = 0.7 * currentAccuracy.resultRatio + currentAccuracy.awayGoalRatio * 0.1+ currentAccuracy.homeGoalRatio * 0.2;
    currentAccuracy.key = key;
    currentAccuracy.Season = league.season;
    currentAccuracy.league = league.leagueName;
    return currentAccuracy;
  }
  double perc(double currD) {return ((currD * 100.0) / 100.0).roundToDouble();}
  void printkeyAccuracy(Accuracy curAccuracy) {
    print("Accuracy Ratios: Total:%" + perc(curAccuracy.resultRatio * 100.0).toString() + " H:%" + perc(curAccuracy.homeRatio * 100.0).toString()  + " D:%" + perc(curAccuracy.drawRatio * 100.0).toString()  + " A:%" + perc(curAccuracy.awayRatio * 100.0).toString()  + " H:" + perc(curAccuracy.key.home).toString()  + " D:" + perc(curAccuracy.key.draw).toString()  + " A:" + perc(curAccuracy.key.away).toString() );
  }
  double calculateElo(Team t1, Team t2, Result r, int team) {
    double win = 1.0;
    double draw = 0.5;
    double loss = 0.0;
    double K_FACTOR = 10.0;
    double elo1=t1.elo;
    double elo2=t2.elo;

    if (elo1 < 1000.0) {
      elo1 = 1000.0;
    }
    if (elo2 < 1000.0) {
      elo2 = 1000.0;
    }
    double probofelo1win = 1.0 / (1.0 + pow(K_FACTOR, (elo2 - elo1) / 400.0));
    double probofelo2win = 1.0 - probofelo1win;
    if (r==Result.H) {
      elo1 += 24.0 * (win - probofelo1win);
      elo2 += 24.0 * (loss - probofelo2win);
    }
    if (r==Result.A) {
      elo1 += 24.0 * (loss - probofelo1win);
      elo2 += 24.0 * (win - probofelo2win);
      if (r==Result.D) {
      }
      elo1 += 24.0* (draw - probofelo1win);
      elo2 += 24.0 * (draw - probofelo2win);
    }
    if (elo1 < 700.0) {
      elo1 = 700.0;
    }
    if (elo2 < 700.0) {
      elo2 = 700.0;
    }
    return team == 1 ? elo1 : elo2;
  }
  League updateMatch(League currentLeague,Match result){
    Team homeTeam=new Team().NewTeam();
    Team awayTeam=new Team().NewTeam();
    homeTeam.teamName=result.homeTeam;
    awayTeam.teamName=result.awayTeam;
    if(currentLeague.Contains(homeTeam.teamName)){homeTeam=currentLeague.Teams[currentLeague.getTeamID(homeTeam.teamName)];}
    if(currentLeague.Contains(awayTeam.teamName)){awayTeam=currentLeague.Teams[currentLeague.getTeamID(awayTeam.teamName)];}
    if (currentLeague.teamNames.contains(homeTeam.teamName)==false){homeTeam.id=currentLeague.leagueSize;currentLeague.addTeam(homeTeam);}
    if (currentLeague.teamNames.contains(awayTeam.teamName)==false){awayTeam.id=currentLeague.leagueSize;currentLeague.addTeam(awayTeam);}
    int hometeamID = currentLeague.getTeamID(result.homeTeam);
    int awayteamID = currentLeague.getTeamID(result.awayTeam);
    homeTeam = currentLeague.Teams[hometeamID];
    awayTeam = currentLeague.Teams[awayteamID];
    ++homeTeam.totalMatch;
    ++homeTeam.homeMatch;
    ++awayTeam.totalMatch;
    ++awayTeam.awayMatch;
    ++currentLeague.totalMatch;
    if (result.result!=Result.EMPTY) {
      awayTeam.totalGoals += result.awayScore;
      awayTeam.totalConcede += result.homeScore;
      awayTeam.awayGoals += result.awayScore;
      awayTeam.awayConcede += result.homeScore;
      homeTeam.totalGoals += result.homeScore;
      homeTeam.totalConcede += result.awayScore;
      homeTeam.homeGoals += result.homeScore;
      homeTeam.homeConcede += result.awayScore;
    }
    if(((result.result==Result.H)||((result.result==Result.EMPTY)&&result.machinePredict==Result.H))){
      ++homeTeam.homeWin;
      ++awayTeam.awayLoses;
      homeTeam.homeForm = homeTeam.homeForm + "W";
      awayTeam.awayForm = awayTeam.awayForm + "L";
      homeTeam.form = homeTeam.form + "W";
      awayTeam.form = awayTeam.form + "L";
      ++homeTeam.win;
      ++awayTeam.loses;
      homeTeam.points += 3;
      ++currentLeague.homeWin;
    }
    if(((result.result==Result.D)||((result.result==Result.EMPTY) &&result.machinePredict==Result.D))){
      ++homeTeam.homeDraws;
      ++awayTeam.awayDraws;
      homeTeam.homeForm = homeTeam.homeForm + "D";
      awayTeam.awayForm = awayTeam.awayForm + "D";
      homeTeam.form = homeTeam.form + "D";
      awayTeam.form = awayTeam.form + "D";
      ++currentLeague.draw;
      ++awayTeam.draws;
      ++homeTeam.draws;
      ++homeTeam.points;
      ++awayTeam.points;
    }
    if(((result.result==Result.A)||((result.result==Result.EMPTY) &&result.machinePredict==Result.A))){
      ++homeTeam.homeLoses;
      ++awayTeam.awayWin;
      homeTeam.homeForm = homeTeam.homeForm + "L";
      awayTeam.awayForm = awayTeam.awayForm + "W";
      homeTeam.form = homeTeam.form + "L";
      awayTeam.form = awayTeam.form + "W";
      ++currentLeague.awayWin;
      ++awayTeam.win;
      awayTeam.points += 3;
      ++homeTeam.loses;
    }
    if (result.result==Result.EMPTY) {
      awayTeam.totalGoals += result.machineAwayScore;
      awayTeam.totalConcede += result.machineHomeScore;
      awayTeam.awayGoals += result.machineAwayScore;
      awayTeam.awayConcede += result.machineHomeScore;
      homeTeam.totalGoals += result.machineHomeScore;
      homeTeam.totalConcede += result.machineAwayScore;
      homeTeam.homeGoals += result.machineHomeScore;
      homeTeam.homeConcede += result.machineAwayScore;}
    if(result.result==Result.EMPTY){double temp=homeTeam.elo; homeTeam.elo =calculateElo(homeTeam, awayTeam, result.machinePredict, 1); double temp2=homeTeam.elo;homeTeam.elo=temp;
    awayTeam.elo = calculateElo(awayTeam, homeTeam, result.machinePredict, 2);
    homeTeam.elo=temp2;
    }
    else{  double temp=homeTeam.elo; homeTeam.elo =calculateElo(homeTeam, awayTeam, result.result, 1); double temp2=homeTeam.elo;homeTeam.elo=temp;
    awayTeam.elo = calculateElo(awayTeam, homeTeam, result.result, 2);
    homeTeam.elo=temp2;
    }
    currentLeague.homeScored += result.homeScore;
    currentLeague.awayScored += result.awayScore;
    currentLeague.Teams[awayteamID]= awayTeam;
    currentLeague.Teams[hometeamID]= homeTeam;
    currentLeague.Results.add(result);
    return currentLeague;
  }
  Accuracy findMaxAcc(String League,int Year){
    Accuracy acc=new Accuracy("",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,randomKey()).newAcc();
    double max=0;
    for(int i=0;i<Keylist.length;i++){
      if(Keylist[i].Season==Year && Keylist[i].league==(League) && Keylist[i].resultRatio>max){max=Keylist[i].resultRatio; acc=Keylist[i];}

    }
    print("Maximum accuracy for "+League+" at "+Year.toString()+" is %"+perc(max*100).toString());
    return acc;
  }

  List<Accuracy> findAccList(String League,int Year){
    Accuracy acc=new Accuracy("",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,randomKey()).newAcc();
    double max=0;
    List<Accuracy> returnList=new List<Accuracy>();
    for(int i=0;i<Keylist.length;i++){
      if(Keylist[i].Season==Year && Keylist[i].league==(League)){acc=Keylist[i];returnList.add(acc);}

    }
    print("Maximum accuracy for "+League+" at "+Year.toString()+" is %"+perc(max*100).toString());
    return returnList;
  }
  void printleagues(){
    LeagueNames=new List();
    LeagueNames.add("Premier League");
    LeagueNames.add("English Championship");
    LeagueNames.add("English League 1");
    LeagueNames.add("English League 2");
    LeagueNames.add("Scottish Premiership");
    LeagueNames.add("Scottish Championship");
    LeagueNames.add("Scottish League 1");
    LeagueNames.add("Scottish League 2");
    LeagueNames.add("Bundesliga");
    LeagueNames.add("Bundesliga 2");
    LeagueNames.add("La Liga");
    LeagueNames.add("Serie A");
    LeagueNames.add("Serie B");
    LeagueNames.add("Superlig");
    LeagueNames.add("La Liga 2");
    LeagueNames.add("Ligue 1");
    LeagueNames.add("Ligue 2");
    LeagueNames.add("Belgian Pro League");
    LeagueNames.add("Eredivisie");
    LeagueNames.add("Liga NOS");
    LeagueNames.add("English Conference");
    LeagueNames.add("Super League 1");
  }
  weightKey inputKey(){
    //*
    //print("Enter weightkey home:");
    //weightKey wk=new weightKey();
    //wk.home =  myObj.nextDouble();
    //print("Enter weightkey draw:");
    //wk.draw = myObj.nextDouble();
    //print("Enter weightkey away:");
    //wk.away =  myObj.nextDouble();
    //print("Enter weightkey powerRank:");
    //wk.powerRank =  myObj.nextDouble();
    //print("Enter weightkey resultPerc:");
    //wk.resultPerc =  myObj.nextDouble();
    //print("Enter weightkey pyEx:");
    //wk.pyEx =  myObj.nextDouble();
    //print("Enter weightkey pyExSide:");
    //wk.pyExSide =  myObj.nextDouble();
    //print("Enter weightkey pattern1:");
    //wk.pattern1 =  myObj.nextDouble();
    //print("Enter weightkey pattern3:");
    //wk.pattern3 =  myObj.nextDouble();
    //print("Enter weightkey pattern5:");
    //wk.pattern5 =  myObj.nextDouble();
    //return wk;

  }
  void UseKey(){
    CurrentLeague=new League();
    Accuracy acc=new Accuracy("",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,randomKey()).newAcc();
    acc.key=key;
    CurrentLeague.leagueName=Matches[0].League;
    CurrentLeague.season=Matches[0].Year;
    for(int i=0;i<Matches.length;i++){
      Match m=Matches[i];
      m=predictMatch(m, key);
      updateMatch(CurrentLeague, m);
    }
    acc=giveAccuracy(CurrentLeague, key);
    database sq=new database();
    sq.uploadResults(CurrentLeague);
    sq.uploadStandings(CurrentLeague);
  }
  void SimulateLeague(){
    CurrentLeague=new League();
    Accuracy acc=new Accuracy("",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,randomKey()).newAcc();
    acc.key=key;
    CurrentLeague.leagueName=Matches[0].League;
    CurrentLeague.season=Matches[0].Year;
    for(int i=0;i<Matches.length;i++){
      Match m=Matches[i];
      m=predictMatch(m, key);
      updateMatch(CurrentLeague, m);
    }
    acc=giveAccuracy(CurrentLeague, key);
    printkeyAccuracy(acc);
    database sq=new database();
    sq.uploadAccuracy(acc);
    sq.uploadResults(CurrentLeague);
    sq.uploadStandings(CurrentLeague);
  }
  void findBetterKey(){
    Accuracy acc=new Accuracy("",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,randomKey()).newAcc();
    int alltries=0;
    double lasth=0;
    double lastd=0;
    double lasta=0;
    int count=0;
    int currentkeytry=0;
    double defaultmin=1.00;
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
    while(acc.resultRatio<defaultmin+0.01 && alltries<1000){
      alltries+=1;
      currentkeytry+=1;
      CurrentLeague=new League();

      CurrentLeague.leagueName=Matches[0].League;
      CurrentLeague.season=Matches[0].Year;
      for(int i=0;i<Matches.length;i++){
        Match m=Matches[0];
        m=predictMatch(m, key);
        updateMatch(CurrentLeague, m);
      }
      acc=giveAccuracy(CurrentLeague, key);
      if(defaultmin!=1){printkeyAccuracy(acc);}
      key=FixKeyAcc(acc);

      count+=1;
      if(acc.resultRatio>defaultmin+0.01 && acc.resultRatio>0.4){print("Couldn't find a better key."); break;}
      if(defaultmin==1){defaultmin=findMaxAcc(CurrentLeague.leagueName, CurrentLeague.season).resultRatio;}
      if(lasth!=acc.guessedHomeRatio ||lastd!=acc.guessedDrawRatio ||lasta!=acc.guessedAwayRatio ){lasth=acc.guessedHomeRatio;lastd=acc.guessedDrawRatio;lasta=acc.guessedAwayRatio;count-=1;}
      if(count>5 || acc.resultRatio<0.30 || currentkeytry>40){key=randomKey();count=0;currentkeytry=0;}
    }
    database sq=new database();
    sq.uploadAccuracy(acc);
    sq.uploadResults(CurrentLeague);
    sq.uploadStandings(CurrentLeague);
  }

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
    return toReturn;
  }
}
