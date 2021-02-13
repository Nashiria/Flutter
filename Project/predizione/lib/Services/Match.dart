class Match {
  Match(
    this.Year,
    this.League,
    this.Country,
    this.Division,
    this.homeTeam,
    this.awayTeam,
    this.homeScore,
    this.awayScore,
    this.result,
  );
  int homeScore;
  int awayScore;
  int GoalCount;
  String homeTeam;
  String awayTeam;
  String League;
  int Year;
  int Division;
  String Country;
  Result result;
  Result machinePredict;
  double machineWinHome;
  double machineWinAway;
  double machineHomeRatio;
  double machineDrawRatio;
  double machineAwayRatio;
  int machineHomeScore;
  int machineAwayScore;
  int machineGoalCount;
  bool CorrectResult;
  bool CorrectHomeScore;
  bool CorrectAwayScore;
  bool CorrectGoalCount;
  Result fromString(String s){
    if(s=="F"){return Result.EMPTY;}
    if(s=="H"){return Result.H;}
    if(s=="D"){return Result.D;}
    else{return Result.A;}
  }
}
enum Result {
  H,
  D,
  A,
  EMPTY
}