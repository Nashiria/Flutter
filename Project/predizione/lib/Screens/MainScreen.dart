import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:predizione/Services/Accuracy.dart';
import 'package:predizione/Services/Match.dart';
import 'package:predizione/Services/Prediction.dart';
import 'package:predizione/Services/Team.dart';
import 'package:predizione/Services/database.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  static const routeName = '/extractArguments';
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Home", Colors.deepPurple),
    new TabItem(Icons.sports_soccer_outlined, "Matches", Colors.black),
    new TabItem(Icons.ballot_outlined, "League", Colors.greenAccent),
    new TabItem(Icons.title, "Teams", Colors.yellow.shade700),
    new TabItem(Icons.contact_mail_outlined, "Dağhan", Colors.cyan),
  ]);

  int index = 0;
  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();

    _navigationController = new CircularBottomNavigationController(index % 10);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Prediction pd = ModalRoute.of(context).settings.arguments;
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text("Predizione"),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            child: bodyContainer(context),
            padding: EdgeInsets.only(bottom: 60),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    ));
  }

  String strRes(Match m) {
    int score1 = 0;
    int score2 = 0;
    if (m.result == Result.EMPTY) {
      score1 = m.machineHomeScore;
      score2 = m.machineAwayScore;
    } else {
      score1 = m.homeScore;
      score2 = m.awayScore;
    }
    if (score1 == score2) {
      return "D";
    } else if (score1 > score2) {
      return "H";
    } else if (score1 < score2) {
      return "A";
    }
  }

  Widget bodyContainer(BuildContext context) {
    Prediction pd = ModalRoute.of(context).settings.arguments;
    List<Match> teamMatches = new List<Match>();
    Team currentTeam = new Team();
    final rows = <TableRow>[];
    final resultsrow = <Container>[];
    final teamcont = <Container>[];
    int cgoalcount = 0;
    int wgoalcount = 0;
    int page = index % 10;
    int team = (((index % 1000) - page) / 10).toInt();
    int playedmatchcount = 0;
    int week = ((index - (page + team)) / 1000).toInt();
    if (week == 0) {
      week = 1;
    }
    if (page == 0 || page == 1 || page == 2 || page == 3) {
      if (page == 2) {
        pd = database().matchList(pd, 0, week);
      }
      List<Match> Results = new List<Match>();
      currentTeam = pd.CurrentLeague.Teams[team];
      for (int i = 0; i < pd.CurrentLeague.Results.length; i++) {
        Match m = pd.CurrentLeague.Results[i];
        m.CorrectGoalCount = (m.machineAwayScore + m.machineHomeScore) ==
            (m.homeScore + m.awayScore);
        if (m.CorrectGoalCount && m.result != Result.EMPTY) {
          cgoalcount += 1;
        }
        if (m.CorrectGoalCount == false && m.result != Result.EMPTY) {
          wgoalcount += 1;
        }
        if (m.result != Result.EMPTY) {
          playedmatchcount += 1;
        }
        if (m.homeTeam == currentTeam.teamName ||
            m.awayTeam == currentTeam.teamName) {
          teamMatches.add(m);
        }
      }

      //if(page==1){ Results=pd.CurrentLeague.Results.sublist((pd.CurrentLeague.Teams.length/2*(week-1)).round(),(pd.CurrentLeague.Teams.length/2*(week)).round());}
      //print("Output:"+index.toString()+" Index:"+(page).toString()+" Team:"+team.toString()+" Week:"+week.toString());
      Results = pd.CurrentLeague.Results;
      //rows.add();

      for (int i = 0; i < pd.CurrentLeague.Teams.length; i++) {
        Color background=Colors.white;
        if(i<3){
          switch(i){
            case 0:
              background=Colors.lightGreen.shade700;
                  break;
            case 1:
              background=Colors.lightGreen.shade400;
              break;
              case 2:
            background=Colors.lightGreen.shade200;
            break;
          }
        }
        else if(i>pd.CurrentLeague.Teams.length-4){
          switch(i+4-pd.CurrentLeague.Teams.length){
            case 3:
              background=Colors.red.shade700;
              break;
            case 2:
              background=Colors.red.shade400;
              break;
            case 1:
              background=Colors.red.shade200;
              break;
          } }
        else if(i%2==0){background=Colors.grey.shade400;}

        rows.add(TableRow(decoration: BoxDecoration(color:background),children: [
          Column(children: [
            Text(
              (i + 1).toString(),
              style: TextStyle(color: Colors.black),
            )
          ]),
          Column(children: [
            FlatButton(
              onPressed: () {
                int indexa = 3 +
                    pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[i]) *
                        10 +
                    50 * 10000;
                setState(() {
                  index = indexa;
                });
              },
              child: Image.asset(pd.CurrentLeague.Teams[i].logodir, width: 50),
            )
          ]),
          Column(children: [
            Text(
              pd.CurrentLeague.Teams[i].totalMatch.toString(),
              style: TextStyle(color: Colors.black),
            )
          ]),
          Column(children: [
            Text(
              pd.CurrentLeague.Teams[i].win.toString(),
              style: TextStyle(color: Colors.black),
            )
          ]),
          Column(children: [
            Text(
              pd.CurrentLeague.Teams[i].draws.toString(),
              style: TextStyle(color: Colors.black),
            )
          ]),
          Column(children: [
            Text(
              pd.CurrentLeague.Teams[i].loses.toString(),
              style: TextStyle(color: Colors.black),
            )
          ]),
          Column(children: [
            Text(
              pd.CurrentLeague.Teams[i].totalGoals.toString(),
              style: TextStyle(color: Colors.black),
            )
          ]),
          Column(children: [
            Text(
              pd.CurrentLeague.Teams[i].totalConcede.toString(),
              style: TextStyle(color: Colors.black),
            )
          ]),
          Column(children: [
            Text(
              (pd.CurrentLeague.Teams[i].totalGoals -
                      pd.CurrentLeague.Teams[i].totalConcede)
                  .toString(),
              style: TextStyle(color: Colors.black),
            )
          ]),
          Column(children: [
            Text(
              pd.CurrentLeague.Teams[i].points.toString(),
              style: TextStyle(color: Colors.black),
            )
          ]),
        ]));
      }

      for (int i = 0; i < Results.length; i++) {
        if (Results[i].result != Result.EMPTY) {
          resultsrow.add(Container(
              height: 140,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FlatButton(
                  onPressed: () {
                    int indexa = 3 +
                        pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[
                                pd.CurrentLeague.getTeamID(
                                    Results[i].homeTeam)]) *
                            10 +
                        50 * 10000;
                    setState(() {
                      index = indexa;
                    });
                  },
                  child: Image.asset(
                      pd
                          .CurrentLeague
                          .Teams[
                              pd.CurrentLeague.getTeamID(Results[i].homeTeam)]
                          .logodir,
                      width: 110),
                ),
                Text(
                  (Results[i].homeScore.toString() +
                      "-" +
                      Results[i].awayScore.toString()),
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                FlatButton(
                  onPressed: () {
                    int indexa = 3 +
                        pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[
                                pd.CurrentLeague.getTeamID(
                                    Results[i].awayTeam)]) *
                            10 +
                        50 * 10000;
                    setState(() {
                      index = indexa;
                    });
                  },
                  child: Image.asset(
                    pd
                        .CurrentLeague
                        .Teams[pd.CurrentLeague.getTeamID(Results[i].awayTeam)]
                        .logodir,
                    width: 110,
                  ),
                ),
              ])));
        } else {
          resultsrow.add(Container(
              height: 140,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FlatButton(
                  onPressed: () {
                    int indexa = 3 +
                        pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[
                                pd.CurrentLeague.getTeamID(
                                    Results[i].homeTeam)]) *
                            10 +
                        50 * 10000;
                    setState(() {
                      index = indexa;
                    });
                  },
                  child: Image.asset(
                      pd
                          .CurrentLeague
                          .Teams[
                              pd.CurrentLeague.getTeamID(Results[i].homeTeam)]
                          .logodir,
                      width: 110),
                ),
                Text(
                  (Results[i].machineHomeScore.toString() +
                      "-" +
                      Results[i].machineAwayScore.toString()),
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                FlatButton(
                  onPressed: () {
                    int indexa = 3 +
                        pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[
                                pd.CurrentLeague.getTeamID(
                                    Results[i].awayTeam)]) *
                            10 +
                        50 * 10000;
                    setState(() {
                      index = indexa;
                    });
                  },
                  child: Image.asset(
                    pd
                        .CurrentLeague
                        .Teams[pd.CurrentLeague.getTeamID(Results[i].awayTeam)]
                        .logodir,
                    width: 110,
                  ),
                ),
              ])));
        }
      }
    }
    String PageName = "";

    switch (index % 10) {
      case 0:
        PageName = "Home";

        break;
      case 1:
        PageName = "Matches";
        break;
      case 2:
        PageName = "League";
        break;
      case 3:
        PageName = "Teams";
        break;
      case 4:
        PageName = "Dağhan";
        break;
    }
    if (PageName == "League") {
      return Center(
          child: ListView(
        children: <Widget>[
          ListView(padding: EdgeInsets.all(0.0),physics: const NeverScrollableScrollPhysics()
              ,scrollDirection: Axis.vertical, shrinkWrap: true,cacheExtent: 50*18.0, children: [
            Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(1),
                6: FlexColumnWidth(1),
                6: FlexColumnWidth(1),
                7: FlexColumnWidth(1),
              },
              border: TableBorder.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 1,
              ),
              children: [TableRow(decoration: BoxDecoration(color:Colors.black),children: [
                Column(children: [
                  Text(
                    '#',
                    style: TextStyle(color: Colors.red, fontSize: 15,fontWeight: FontWeight.bold),
                  )
                ]),
                Column(children: [
                  Text(
                    'Team',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  )
                ]),
                Column(children: [
                  Text(
                    'Total',
                    style: TextStyle(color: Colors.red),
                  )
                ]),
                Column(children: [
                  Text(
                    'Win',
                    style: TextStyle(color: Colors.red),
                  )
                ]),
                Column(children: [
                  Text(
                    'Draw',
                    style: TextStyle(color: Colors.red),
                  )
                ]),
                Column(children: [
                  Text(
                    'Lose',
                    style: TextStyle(color: Colors.red),
                  )
                ]),
                Column(children: [
                  Text(
                    'GS',
                    style: TextStyle(color: Colors.red),
                  )
                ]),
                Column(children: [
                  Text(
                    'GC',
                    style: TextStyle(color: Colors.red),
                  )
                ]),
                Column(children: [
                  Text(
                    'GD',
                    style: TextStyle(color: Colors.red),
                  )
                ]),
                Column(children: [
                  Text(
                    'Point',
                    style: TextStyle(color: Colors.red),
                  )
                ]),
              ]),]

            ),
          ]),
          ListView(physics: const NeverScrollableScrollPhysics(),padding: EdgeInsets.all(0.0),scrollDirection: Axis.vertical, shrinkWrap: true,cacheExtent: 50*18.0, children: [
                Table(
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1),
                    6: FlexColumnWidth(1),
                    6: FlexColumnWidth(1),
                    7: FlexColumnWidth(1),
                  },
                  border: TableBorder.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                  children: rows,

            ),
          ]),

        ],
      ));
    }

    if (PageName == "Matches") {
      return Center(
        child: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: resultsrow),
      );
    }
    if (PageName == "Home") {
      Accuracy ac = pd.giveAccuracy(pd.CurrentLeague, pd.key);
      const double fonts = 35.0;

      return Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
          child: new Column(children: [
            Text("Accuracy Ratios:",
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: fonts)),
            Text("Total: %" + pd.perc(ac.resultRatio * 100).toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: fonts)),
            Text("Home Wins: %" + pd.perc(ac.homeRatio * 100).toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: fonts)),
            Text("Draw Matches: %" + pd.perc(ac.drawRatio * 100).toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: fonts)),
            Text("Away Wins: %" + pd.perc(ac.awayRatio * 100).toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: fonts)),
            Text("Home Goals: %" + pd.perc(ac.homeGoalRatio * 100).toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: fonts)),
            Text("Away Goals: %" + pd.perc(ac.awayGoalRatio * 100).toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: fonts)),
            Text(
                "Goal Count: %" +
                    pd
                        .perc(100 * cgoalcount / (cgoalcount + wgoalcount))
                        .toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: fonts)),
          ]));
    }
    if (PageName == "Teams") {
      for (int i = 0; i < teamMatches.length; i++) {
        Match m = teamMatches[i];
        if (m.result != Result.EMPTY) {
          teamcont.add(Container(
              height: 140,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FlatButton(
                  onPressed: () {
                    int indexa = 3 +
                        pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[
                                pd.CurrentLeague.getTeamID(m.homeTeam)]) *
                            10 +
                        50 * 10000;
                    setState(() {
                      index = indexa;
                    });
                  },
                  child: Image.asset(
                      pd
                          .CurrentLeague
                          .Teams[pd.CurrentLeague.getTeamID(m.homeTeam)]
                          .logodir,
                      width: 110),
                ),
                Text(
                  (m.homeScore.toString() + "-" + m.awayScore.toString()),
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                FlatButton(
                  onPressed: () {
                    int indexa = 3 +
                        pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[
                                pd.CurrentLeague.getTeamID(m.awayTeam)]) *
                            10 +
                        50 * 10000;
                    setState(() {
                      index = indexa;
                    });
                  },
                  child: Image.asset(
                    pd.CurrentLeague
                        .Teams[pd.CurrentLeague.getTeamID(m.awayTeam)].logodir,
                    width: 110,
                  ),
                ),
              ])));
        } else {
          teamcont.add(Container(
              height: 140,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FlatButton(
                  onPressed: () {
                    int indexa = 3 +
                        pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[
                                pd.CurrentLeague.getTeamID(m.homeTeam)]) *
                            10 +
                        50 * 10000;
                    setState(() {
                      index = indexa;
                    });
                  },
                  child: Image.asset(
                      pd
                          .CurrentLeague
                          .Teams[pd.CurrentLeague.getTeamID(m.homeTeam)]
                          .logodir,
                      width: 110),
                ),
                Text(
                  (m.machineHomeScore.toString() +
                      "-" +
                      m.machineAwayScore.toString()),
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                FlatButton(
                  onPressed: () {
                    int indexa = 3 +
                        pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[
                                pd.CurrentLeague.getTeamID(m.awayTeam)]) *
                            10 +
                        50 * 10000;
                    setState(() {
                      index = indexa;
                    });
                  },
                  child: Image.asset(
                    pd.CurrentLeague
                        .Teams[pd.CurrentLeague.getTeamID(m.awayTeam)].logodir,
                    width: 110,
                  ),
                ),
              ])));
        }
      }
      currentTeam = pd.CurrentLeague.Teams[team];
      int teamrank = 0;
      for (int i = 0; i < pd.CurrentLeague.Teams.length; i++) {
        if (currentTeam.teamName == pd.CurrentLeague.Teams[i].teamName) {
          teamrank = i;
        }
      }
      return Center(
          child: new ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: [
          Center(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background2.jpg"),
                    fit: BoxFit.cover)),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 150,
              child: Container(
                alignment: Alignment(0.0, 0),
                child: Image(
                  image: AssetImage(currentTeam.logodir),
                  alignment: Alignment.center,
                ),
              ),
            ),
          )),
          Center(
            child: Text(
              currentTeam.teamName,
              style: TextStyle(
                fontSize: 45.0,
                color: Colors.black,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 10,
            ),
          ),
          Center(
            child: Text(
              "League ranking: " +
                  (pd.CurrentLeague.getTeamIndex(currentTeam) + 1).toString(),
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Center(
            child: SizedBox(
              height: 5,
            ),
          ),
          Center(
            child: SizedBox(
              height: 10,
            ),
          ),
          Center(
            child: Text(
              "Wins: " +
                  currentTeam.win.toString() +
                  " Draws: " +
                  currentTeam.draws.toString() +
                  " Loses: " +
                  currentTeam.loses.toString(),
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Center(
            child: SizedBox(
              height: 10,
            ),
          ),
          Center(
            child: Text(
              "Matches:",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Center(child: ListView(shrinkWrap: true,physics: const NeverScrollableScrollPhysics(), children: teamcont)),
        ],
      ));
    }

    if (PageName == "Dağhan") {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.jpg"),
                    fit: BoxFit.cover)),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: Alignment(0.0, 2.5),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/Profile.jpg"),
                  radius: 60.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            "Dağhan Sinan",
            style: TextStyle(
              fontSize: 45.0,
              color: Colors.green.shade900,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "İstanbul, Türkiye",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "daghansinan@gmail.com",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "github.com/Nashiria",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
        ],
      );
    }
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: 60,
      barBackgroundColor: Colors.redAccent,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int sindex) {
        setState(() {
          index = sindex;
        });
      },
    );
  }
}
