import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Team {
  int id;
  String  teamName;
  String  country;
  String  league;
  int totalMatch=0;
  int homeMatch=0;
  int awayMatch=0;
  int win=0;
  int draws=0;
  int loses=0;
  int homeWin=0;
  int homeDraws=0;
  int homeLoses=0;
  int awayWin=0;
  int awayDraws=0;
  int awayLoses=0;
  String form;
  String homeForm;
  String awayForm;
  int totalGoals=0;
  int homeGoals=0;
  int awayGoals=0;
  int totalConcede=0;
  int homeConcede=0;
  int awayConcede=0;
  int leaguePoints=0;
  String logodir;
  double elo=1100;
  int points=0;
  Team NewTeam(){
    Team newTeam=new Team();
    newTeam.id=0;
    newTeam.teamName="";
    newTeam.country="";
    newTeam.league="";
    newTeam.totalMatch=0;
    newTeam.homeMatch=0;
    newTeam.awayMatch=0;
    newTeam.win=0;
    newTeam.draws=0;
    newTeam.loses=0;
    newTeam.homeWin=0;
    newTeam.homeDraws=0;
    newTeam.homeLoses=0;
    newTeam.awayWin=0;
    newTeam.awayDraws=0;
    newTeam.awayLoses=0;
    newTeam.form="";
    newTeam.homeForm="";
    newTeam.awayForm="";
    newTeam.totalGoals=0;
    newTeam.homeGoals=0;
    newTeam.awayGoals=0;
    newTeam.totalConcede=0;
    newTeam.homeConcede=0;
    newTeam.awayConcede=0;
    newTeam.leaguePoints=0;
    newTeam.elo=1100;
    newTeam.points=0;
    newTeam.logodir="";
    return newTeam;
  }

}
