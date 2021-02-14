import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:mysql1/mysql1.dart';
import 'package:predizione/Services/weightKey.dart';
import 'Match.dart';
import 'Accuracy.dart';
import 'League.dart';
import 'Odd.dart';
import 'Prediction.dart';
import 'Team.dart';
import 'dart:math';
class database {


  Result rfromS(String s){
    if(s=="F"){return Result.EMPTY;}
    if(s=="H"){return Result.H;}
    if(s=="D"){return Result.D;}
    else{return Result.A;}
  }
  Prediction matchList(Prediction pd,int start,int end){
    List<Match> Matches=new List<Match>();
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Tankspor',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Parlakspor',0,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Buzspor',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Peynirdibi',3,5,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Nehirdibi',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Halterspor',0,1,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Portakalspor',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Kumspor',0,1,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Villadibi',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Altinsaray',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Zarhane',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Kurtspor',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Hedefspor',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Odunhane',0,1,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Tophane',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Deredibi',4,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Eskikapi',3,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Odunhane',3,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Zarhane',4,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Totemspor',3,3,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Peynirdibi',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Kumspor',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Nehirdibi',4,2,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Eskikapi',3,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Tankspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Portakalspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Hedefspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Deredibi',3,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Nehirdibi',1,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Kurtspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Halterspor',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Totemspor',4,4,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Parlakspor',1,4,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Buzspor',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Eskikapi',0,1,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Peynirdibi',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Tophane',0,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Zarhane',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Hedefspor',5,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Kumspor',0,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Villadibi',0,0,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Portakalspor',0,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Buzspor',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Altinsaray',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Halterspor',0,13,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Tophane',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Tankspor',0,0,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Kurtspor',4,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Odunhane',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Deredibi',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Portakalspor',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Parlakspor',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Totemspor',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Altinsaray',5,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Buzspor',5,2,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Peynirdibi',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Kumspor',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Villadibi',4,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Parlakspor',2,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Hedefspor',1,4,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Nehirdibi',4,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Eskikapi',3,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Altinsaray',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Tophane',2,4,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Deredibi',3,2,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Zarhane',0,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Halterspor',0,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Odunhane',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Kurtspor',3,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Totemspor',0,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Tankspor',3,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Peynirdibi',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Kumspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Villadibi',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Deredibi',5,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Parlakspor',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Nehirdibi',6,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Portakalspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Hedefspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Kurtspor',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Eskikapi',0,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Halterspor',0,5,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Hedefspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Altinsaray',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Buzspor',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Villadibi',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Tankspor',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Totemspor',1,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Zarhane',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Kurtspor',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Peynirdibi',3,2,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Tankspor',3,2,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Tophane',1,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Kumspor',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Deredibi',0,0,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Odunhane',1,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Nehirdibi',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Portakalspor',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Buzspor',1,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Eskikapi',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Nehirdibi',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Altinsaray',4,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Hedefspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Parlakspor',0,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Zarhane',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Villadibi',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Totemspor',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Kurtspor',0,0,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Odunhane',2,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Tophane',1,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Portakalspor',1,4,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Buzspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Parlakspor',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Halterspor',2,4,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Deredibi',1,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Tankspor',5,3,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Eskikapi',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Villadibi',2,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Peynirdibi',4,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Zarhane',0,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Kumspor',3,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Halterspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Altinsaray',0,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Deredibi',0,1,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Hedefspor',3,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Totemspor',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Nehirdibi',0,1,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Tophane',1,4,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Kumspor',0,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Totemspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Odunhane',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Parlakspor',0,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Buzspor',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Tankspor',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Portakalspor',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Villadibi',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Kurtspor',4,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Totemspor',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Peynirdibi',1,4,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Zarhane',0,1,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Altinsaray',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Eskikapi',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Halterspor',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Odunhane',2,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Kumspor',1,4,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Portakalspor',3,5,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Deredibi',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Buzspor',0,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Nehirdibi',2,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Tankspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Tophane',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Hedefspor',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Parlakspor',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Altinsaray',1,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Kurtspor',0,0,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Odunhane',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Eskikapi',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Hedefspor',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Halterspor',1,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Peynirdibi',0,1,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Zarhane',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Totemspor',2,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Deredibi',2,2,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Portakalspor',0,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Nehirdibi',3,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Villadibi',0,1,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Kumspor',4,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Buzspor',1,2,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Parlakspor',3,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Tankspor',3,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Tophane',0,0,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Odunhane',1,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Altinsaray',3,3,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Peynirdibi',3,2,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Eskikapi',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Hedefspor',0,0,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Portakalspor',3,1,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Kurtspor',2,0,rfromS('H')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Halterspor',0,3,rfromS('A')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Zarhane',1,1,rfromS('D')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Deredibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Tophane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Eskikapi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Totemspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Kumspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Parlakspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Villadibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Nehirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Zarhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Portakalspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Hedefspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Altinsaray',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Peynirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Tankspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Halterspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Kurtspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Buzspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Tophane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Zarhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Altinsaray',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Parlakspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Nehirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Kumspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Deredibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Odunhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Totemspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Villadibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Eskikapi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Parlakspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Buzspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Kurtspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Tophane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Hedefspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Halterspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Tankspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Peynirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Odunhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Zarhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Tankspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Peynirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Portakalspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Altinsaray',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Villadibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Nehirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Totemspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Deredibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Tophane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Kurtspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Kumspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Halterspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Parlakspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Eskikapi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Buzspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Hedefspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Nehirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Portakalspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Kurtspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Villadibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Zarhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Peynirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Odunhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Tophane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Tankspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Villadibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Eskikapi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Kumspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Buzspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Deredibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Halterspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Altinsaray',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Odunhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Totemspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Zarhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Hedefspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Parlakspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Kurtspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Tankspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Tophane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Halterspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Nehirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Portakalspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Buzspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Totemspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Deredibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Villadibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Kumspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Odunhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Altinsaray',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Peynirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Eskikapi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Parlakspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Kurtspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Zarhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Tankspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Tophane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Peynirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Hedefspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Totemspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Altinsaray',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Buzspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Odunhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Deredibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Halterspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Nehirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Villadibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Kumspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Eskikapi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Portakalspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Nehirdibi','Tankspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Halterspor','Peynirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kurtspor','Hedefspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Odunhane','Totemspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Buzspor','Kumspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Deredibi','Parlakspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Portakalspor','Altinsaray',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Eskikapi','Tophane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Zarhane','Villadibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Totemspor','Deredibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tophane','Nehirdibi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Villadibi','Portakalspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Parlakspor','Eskikapi',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Altinsaray','Odunhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Hedefspor','Zarhane',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Kumspor','Halterspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Peynirdibi','Kurtspor',0,0,rfromS('F')));
    Matches.add(Match(2020,'Mahalle Ligi','Türkiye',1,'Tankspor','Buzspor',0,0,rfromS('F')));
    int teamcount=0;
    if(Matches.length==24*23){teamcount=24;}
    if(Matches.length==23*22){teamcount=23;}
    if(Matches.length==22*21){teamcount=22;}
    if(Matches.length==21*20){teamcount=21;}
    if(Matches.length==20*19){teamcount=20;}
    if(Matches.length==19*18){teamcount=19;}
    if(Matches.length==18*17){teamcount=18;}
    if(Matches.length==17*16){teamcount=17;}
    if(Matches.length==16*15){teamcount=16;}

    int weeklymatch=(teamcount/2).round();
    int matchesplayed=end*weeklymatch;
    if(matchesplayed>Matches.length){matchesplayed=Matches.length;}
    Matches=Matches.sublist(start*weeklymatch,matchesplayed);

    pd.Matches=Matches;

    return pd;
  }
  List<Odd> betOdds(){
    List<Odd> Odds=new List<Odd>();
    Odds.add(Odd(0.02,0.26));
    Odds.add(Odd(0.03,0.26));
    Odds.add(Odd(0.04,0.26));
    Odds.add(Odd(0.05,0.26));
    Odds.add(Odd(0.06,0.26));
    Odds.add(Odd(0.07,0.26));
    Odds.add(Odd(0.08,0.26));
    Odds.add(Odd(0.09,0.26));
    Odds.add(Odd(0.1,0.26));
    Odds.add(Odd(0.11,0.26));
    Odds.add(Odd(0.12,0.26));
    Odds.add(Odd(0.13,0.26));
    Odds.add(Odd(0.14,0.26));
    Odds.add(Odd(0.15,0.26));
    Odds.add(Odd(0.16,0.26));
    Odds.add(Odd(0.17,0.26));
    Odds.add(Odd(0.18,0.26));
    Odds.add(Odd(0.19,0.26));
    Odds.add(Odd(0.2,0.26));
    Odds.add(Odd(0.21,0.26));
    Odds.add(Odd(0.22,0.26));
    Odds.add(Odd(0.23,0.26));
    Odds.add(Odd(0.24,0.26));
    Odds.add(Odd(0.25,0.26));
    Odds.add(Odd(0.26,0.26));
    Odds.add(Odd(0.27,0.26));
    Odds.add(Odd(0.28,0.26));
    Odds.add(Odd(0.29,0.26));
    Odds.add(Odd(0.3,0.26));
    Odds.add(Odd(0.31,0.26));
    Odds.add(Odd(0.32,0.26));
    Odds.add(Odd(0.33,0.26));
    Odds.add(Odd(0.34,0.26));
    Odds.add(Odd(0.35,0.26));
    Odds.add(Odd(0.36,0.26));
    Odds.add(Odd(0.37,0.26));
    Odds.add(Odd(0.38,0.26));
    Odds.add(Odd(0.39,0.26));
    Odds.add(Odd(0.4,0.26));
    Odds.add(Odd(0.41,0.26));
    Odds.add(Odd(0.42,0.26));
    Odds.add(Odd(0.43,0.26));
    Odds.add(Odd(0.44,0.26));
    Odds.add(Odd(0.45,0.26));
    Odds.add(Odd(0.46,0.26));
    Odds.add(Odd(0.47,0.26));
    Odds.add(Odd(0.48,0.26));
    Odds.add(Odd(0.49,0.26));
    Odds.add(Odd(0.5,0.26));
    Odds.add(Odd(0.51,0.26));
    Odds.add(Odd(0.52,0.26));
    Odds.add(Odd(0.53,0.25));
    Odds.add(Odd(0.54,0.25));
    Odds.add(Odd(0.55,0.25));
    Odds.add(Odd(0.56,0.25));
    Odds.add(Odd(0.57,0.25));
    Odds.add(Odd(0.58,0.25));
    Odds.add(Odd(0.59,0.25));
    Odds.add(Odd(0.6,0.24));
    Odds.add(Odd(0.61,0.24));
    Odds.add(Odd(0.62,0.24));
    Odds.add(Odd(0.63,0.24));
    Odds.add(Odd(0.64,0.24));
    Odds.add(Odd(0.65,0.23));
    Odds.add(Odd(0.66,0.23));
    Odds.add(Odd(0.67,0.23));
    Odds.add(Odd(0.68,0.23));
    Odds.add(Odd(0.69,0.22));
    Odds.add(Odd(0.7,0.22));
    Odds.add(Odd(0.71,0.22));
    Odds.add(Odd(0.72,0.21));
    Odds.add(Odd(0.73,0.21));
    Odds.add(Odd(0.74,0.20));
    Odds.add(Odd(0.75,0.20));
    Odds.add(Odd(0.76,0.20));
    Odds.add(Odd(0.77,0.19));
    Odds.add(Odd(0.78,0.19));
    Odds.add(Odd(0.79,0.18));
    Odds.add(Odd(0.8,0.18));
    Odds.add(Odd(0.81,0.17));
    Odds.add(Odd(0.82,0.17));
    Odds.add(Odd(0.83,0.16));
    Odds.add(Odd(0.84,0.16));
    Odds.add(Odd(0.85,0.15));
    Odds.add(Odd(0.86,0.14));
    Odds.add(Odd(0.87,0.14));
    Odds.add(Odd(0.88,0.13));
    Odds.add(Odd(0.89,0.12));
    Odds.add(Odd(0.9,0.12));
    Odds.add(Odd(0.91,0.11));
    Odds.add(Odd(0.92,0.10));
    Odds.add(Odd(0.93,0.09));
    Odds.add(Odd(0.94,0.08));
    Odds.add(Odd(0.95,0.06));
    Odds.add(Odd(0.96,0.06));
  return Odds;

  }
  void uploadStandings(League a){//for(int i=0;i<a.Teams.length;i++){print(i.toString()+" "+a.Teams[i].teamName+" "+a.Teams[i].totalMatch.toString()+" "+a.Teams[i].points.toString());}
    }
  void uploadResults(League a){
    //for(int i=0;i<a.Results.length;i++){print(i.toString()+" "+a.Results[i].homeTeam+" "+a.Results[i].awayTeam+" "+(a.Results[i].result==a.Results[i].machinePredict).toString());}
    }
  void uploadAccuracy(Accuracy acc){}
  List<Accuracy> keyList(){
    List<Accuracy> wk=new List<Accuracy>();
    // 48 wk.add(Accuracy('Mahalle Ligi',2020,0.5166666666666667,0.45444443966779446,55,57,93,125,87,123,180,0.3055555555555556,0.31666666666666665,55,69,56,43,22,28,26,27,34,0.6231884057971014,0.4489795918367347,0.45161290322580644,0.38333333333333336,0.3055555555555556,0.3111111111111111,weightKey(100.0,112.16666666666667,114.5,3.0,1.0,-7.0,0.0,0.0,0.0,0.0)));
    // 48 wk.add(Accuracy('Mahalle Ligi',2020,0.48333333333333334,0.43777777349783314,55,69,87,125,93,111,180,0.3055555555555556,0.38333333333333336,50,76,54,46,14,27,23,35,35,0.6666666666666666,0.2857142857142857,0.43548387096774194,0.4222222222222222,0.2777777777777778,0.3,weightKey(104.0,100.0,109.0,4.0,-3.0,-6.0,0.0,0.0,0.0,0.0)));
    // 46 wk.add(Accuracy('Mahalle Ligi',2020,0.5055555555555555,0.4361111063096258,46,56,91,134,89,124,180,0.25555555555555554,0.3111111111111111,0,121,59,58,0,33,11,49,29,0.8405797101449275,0.0,0.532258064516129,0.6722222222222223,0.0,0.3277777777777778,weightKey(139.04761904761904,130.0,122.83333333333334,3.0,-2.0,8.0,0.0,0.0,0.0,0.0)));
    // 48wk.add(Accuracy('Mahalle Ligi',2020,0.5166666666666667,0.45444443966779446,55,57,93,125,87,123,180,0.3055555555555556,0.31666666666666665,55,69,56,43,22,28,26,27,34,0.6231884057971014,0.4489795918367347,0.45161290322580644,0.38333333333333336,0.3055555555555556,0.3111111111111111,weightKey(100.0,112.16666666666667,114.5,3.0,1.0,-7.0,0.0,0.0,0.0,0.0)));

    wk.add(Accuracy('Mahalle Ligi',2020,0.4111111111111111,0.3883333299309015,60,61,74,120,106,119,180,0.3333333333333333,0.3388888888888889,71,77,32,40,17,17,29,32,45,0.5797101449275363,0.3469387755102041,0.27419354838709675,0.42777777777777776,0.39444444444444443,0.17777777777777778,weightKey(153.52941176470588,138.24561403508773,140.01754385964912,-2.0,0.0,-6.0,0.0,0.0,0.0,0.0)));

    return wk;
  }


    Prediction loadDatabase(){
    Prediction pd=new Prediction();
    pd.betOdds= betOdds();
    pd.Keylist= keyList();
    return pd;
  }
}
