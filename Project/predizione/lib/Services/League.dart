
import 'package:predizione/Services/Team.dart';
import 'package:predizione/Services/Match.dart';
class League {
  int season;
  String leagueName;
  List<Team> Teams=new List<Team>();
  List<String> teamNames=new List<String>();
  int leagueSize=0;
  int totalMatch=0;
  int homeWin=0;
  int draw=0;
  int awayWin=0;
  int homeScored=0;
  int awayScored=0;
  List<Match> Results=new List<Match>();
  void Main(){}
  bool Contains(String teamName){

    if(teamNames.contains(teamName)){
      return true;
    }
    return false;

  }
  int getTeamID(String teamName){
    for(int i=0;i<Teams.length;i++){
      if(teamName==Teams[i].teamName){return i;}


    }
  }
  void addTeam(Team newTeam){teamNames.add(newTeam.teamName);newTeam.id=leagueSize;leagueSize+=1;newTeam.logodir="assets/"+newTeam.teamName+".png";;Teams.add(newTeam);}//System.out.println(Teams.get(leagueSize-1).teamName);

  void SetTeam(Team team){

    for(int i=0;i<Teams.length;i++){

      if(team.teamName==Teams[i].teamName){
        Teams[i]=team;

      }
    }

  }
 int getTeamIndex(Team team){
    for(int i=0;i<Teams.length;i++){
      if(team.teamName==Teams[i].teamName){return i;}


    }


 }
  void printTeams(){for(int i=0;i<Teams.length;i++){print(Teams[i].teamName);}}


}
