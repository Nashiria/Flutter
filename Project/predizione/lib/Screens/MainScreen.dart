import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:predizione/Services/Match.dart';
import 'package:predizione/Services/Prediction.dart';
import 'package:predizione/Services/Team.dart';
import 'package:predizione/Services/database.dart';

void main() {
  runApp(MainScreen());


}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Home", Colors.blue),
    new TabItem(Icons.sports_soccer_outlined, "Matches", Colors.black),
    new TabItem(Icons.ballot_outlined, "League", Colors.red),
    new TabItem(Icons.settings_outlined, "Info", Colors.cyan),
    new TabItem(Icons.contact_mail_outlined, "Dağhan", Colors.cyan),
  ]);

  int index = 0;
  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();

    _navigationController = new CircularBottomNavigationController(index%10);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text("Predizione"),
      ),
      body: Stack(
        children: <Widget>[
          Padding(child: bodyContainer(), padding: EdgeInsets.only(bottom: 60),),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }
  String strRes(Match m){
    int score1=0;
    int score2=0;
    if(m.result==Result.EMPTY){score1=m.machineHomeScore;score2=m.machineAwayScore;}
    else{score1=m.homeScore;score2=m.awayScore;}
    if(score1==score2){return "D";}
    else if(score1>score2){return "H";}
    else if(score1<score2){return "A";}

  }

  Widget bodyContainer() {

    Prediction pd=new Prediction();
    database db=new database();
    List<Match> teamMatches=new List<Match>();
    Team currentTeam=new Team();
    final rows = <TableRow>[];
    final resultsrow = <Container>[];
    final teamcont = <Container>[];
    int page=index%10;
    int team=(((index%1000)-page)/10).toInt();
    int week=((index-(page+team))/1000).toInt();
    if(week==0){week=1;}
    String slogan;
    if(page==0 || page==1 || page==2 ||page==3){

      pd=database().loadDatabase();
      pd=database().matchList(pd,0,50);

      if(page==2){pd=database().matchList(pd,0,week);}
      List<Match> Results=new List<Match>();
      pd.key=pd.findMaxAcc("Mahalle Ligi", 2020).key;
      pd.SimulateLeague();
      currentTeam=pd.CurrentLeague.Teams[team];

      for(int i=0;i<pd.CurrentLeague.Results.length;i++){
        Match m=pd.CurrentLeague.Results[i];
        if(m.homeTeam==currentTeam.teamName || m.awayTeam==currentTeam.teamName){
          teamMatches.add(m);
        }


      }

      //if(page==1){ Results=pd.CurrentLeague.Results.sublist((pd.CurrentLeague.Teams.length/2*(week-1)).round(),(pd.CurrentLeague.Teams.length/2*(week)).round());}
      print("Output:"+index.toString()+" Index:"+(page).toString()+" Team:"+team.toString()+" Week:"+week.toString());
      Results=pd.CurrentLeague.Results;
      rows.add(TableRow( children: [
        Column(children:[Text(
          'Rank',
          style: TextStyle(color: Colors.red,fontSize: 15),
        )]),
        Column(children:[Text(
          'Team',
          style: TextStyle(color: Colors.red,fontSize: 15),
        )]),
        Column(children:[Text(
          'Total',
          style: TextStyle(color: Colors.red),
        )]),
        Column(children:[Text(
          'Win',
          style: TextStyle(color: Colors.red),
        )]),
        Column(children:[Text(
          'Draw',
          style: TextStyle(color: Colors.red),
        )]),
        Column(children:[Text(
          'Lose',
          style: TextStyle(color: Colors.red),
        )]),
        Column(children:[Text(
          'GS',
          style: TextStyle(color: Colors.red),
        )]),
        Column(children:[Text(
          'GC',
          style: TextStyle(color: Colors.red),
        )]),
        Column(children:[Text(
          'GD',
          style: TextStyle(color: Colors.red),
        )]),
        Column(children:[Text(
          'Point',
          style: TextStyle(color: Colors.red),
        )]),

      ]));

      for(int i=0;i<pd.CurrentLeague.Teams.length;i++){
        rows.add(TableRow( children: [
          Column(children:[Text(
            (i+1).toString(),
            style: TextStyle(color: Colors.black),
          )]),
          Column(children:[Text(
            pd.CurrentLeague.Teams[i].teamName,
            style: TextStyle(color: Colors.black),
          )]),
          Column(children:[Text(
            pd.CurrentLeague.Teams[i].totalMatch.toString(),
            style: TextStyle(color: Colors.black),
          )]),
          Column(children:[Text(
            pd.CurrentLeague.Teams[i].win.toString(),
            style: TextStyle(color: Colors.black),
          )]),
          Column(children:[Text(
            pd.CurrentLeague.Teams[i].draws.toString(),
            style: TextStyle(color: Colors.black),
          )]),
          Column(children:[Text(
            pd.CurrentLeague.Teams[i].loses.toString(),
            style: TextStyle(color: Colors.black),
          )]),
          Column(children:[Text(
            pd.CurrentLeague.Teams[i].totalGoals.toString(),
            style: TextStyle(color: Colors.black),
          )]),
          Column(children:[Text(
            pd.CurrentLeague.Teams[i].totalConcede.toString(),
            style: TextStyle(color: Colors.black),
          )]),
          Column(children:[Text(
            (pd.CurrentLeague.Teams[i].totalGoals-pd.CurrentLeague.Teams[i].totalConcede).toString(),
            style: TextStyle(color: Colors.black),
          )]),
          Column(children:[Text(
            pd.CurrentLeague.Teams[i].points.toString(),
            style: TextStyle(color: Colors.black),
          )]),

        ]));
      }


      for(int i=0;i<Results.length;i++){      if(Results[i].result!=Result.EMPTY) {
        resultsrow.add(Container(
          height: 140,
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Home team logo
              SizedBox(
                width: 110,
                height: 110,
                child:
                FlatButton(
                  onPressed: () {
                    int indexa=3+pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(Results[i].homeTeam)])*10+50*10000;
                    setState(() {
                      index=indexa;
                    });
                  },
                  child: Image.asset(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(Results[i].homeTeam)].logodir),
                ),

              ),
            ]),
            Padding(padding: EdgeInsets.all(4)),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              // Propagate data down to the widgets that need it
              // The Highlights text has a rounded border
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFB4B4B4)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                child: Text(
                  (Results[i].homeScore.toString()+"-"+Results[i].awayScore.toString()),
                  style: TextStyle(fontFamily: 'OpenSans', fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
            ]),
            Padding(padding: EdgeInsets.all(4)),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Home team logo
              SizedBox(
                width: 110,
                height: 110,
                child:
                FlatButton(
                  onPressed: () {
                    int indexa=3+pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(Results[i].awayTeam)])*10+50*10000;
                    setState(() {
                      index=indexa;
                    });
                  },
                  child: Image.asset(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(Results[i].awayTeam)].logodir),
                ),

              ),
            ]),
          ]),
        ));
      }else{
        resultsrow.add(Container(
          height: 140,
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Home team logo
              SizedBox(
                width: 110,
                height: 110,
                child:
                FlatButton(
                  onPressed: () {
                    int indexa=3+pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(Results[i].homeTeam)])*10+50*10000;
                    setState(() {
                      index=indexa;
                    });
                  },
                  child: Image.asset(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(Results[i].homeTeam)].logodir),
                ),

              ),
            ]),
            Padding(padding: EdgeInsets.all(4)),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              // Propagate data down to the widgets that need it
              // The Highlights text has a rounded border
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFB4B4B4)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                child: Text(
                  (Results[i].machineHomeScore.toString()+"-"+Results[i].machineAwayScore.toString()),
                  style: TextStyle(fontFamily: 'OpenSans', fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
            ]),
            Padding(padding: EdgeInsets.all(4)),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Home team logo
              SizedBox(
                width: 110,
                height: 110,
                child:
                FlatButton(
                  onPressed: () {
                    print('I got clicked');
                  },
                  child: Image.asset(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(Results[i].awayTeam)].logodir),
                ),

              ),
            ]),
          ]),
        ));
      }}}
    String PageName="";

    switch (index%10) {
      case 0:
        PageName="Home";

        break;
      case 1:
        PageName="Matches";
        break;
      case 2:
        PageName="League";
        break;
      case 3:
        PageName="Teams";
        break;
      case 4:
        PageName="Info";
        break;
      case 5:
        PageName="Dağhan";
        break;
    }
    if(PageName=="Matches"){ return Center(
      child: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: resultsrow
      ),
    );
    }

    if(PageName=="Teams"){
      for(int i=0;i<teamMatches.length;i++){
        Match m=teamMatches[i];
        if(m.result!=Result.EMPTY) {
          teamcont.add(Container(
            height: 140,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                // Home team logo
                SizedBox(
                  width: 110,
                  height: 110,
                  child:
                  FlatButton(
                    onPressed: () {
                      int indexa=3+pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(m.homeTeam)])*10+50*10000;
                      setState(() {
                        index=indexa;
                      });
                    },
                    child: Image.asset(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(m.homeTeam)].logodir),
                  ),

                ),
              ]),
              Padding(padding: EdgeInsets.all(4)),
              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                // Propagate data down to the widgets that need it
                // The Highlights text has a rounded border
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFFB4B4B4)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                  child: Text(
                    (m.homeScore.toString()+"-"+m.awayScore.toString()),
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
              ]),
              Padding(padding: EdgeInsets.all(4)),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                // Home team logo
                SizedBox(
                  width: 110,
                  height: 110,
                  child:
                  FlatButton(
                    onPressed: () {
                      int indexa=3+pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(m.awayTeam)])*10+50*10000;
                      setState(() {
                        index=indexa;
                      });
                    },
                    child: Image.asset(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(m.awayTeam)].logodir),
                  ),

                ),
              ]),
            ]),
          ));
        }else{
          resultsrow.add(Container(
            height: 140,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                // Home team logo
                SizedBox(
                  width: 110,
                  height: 110,
                  child:
                  FlatButton(
                    onPressed: () {
                      int indexa=3+pd.CurrentLeague.getTeamIndex(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(m.homeTeam)])*10+50*10000;
                      setState(() {
                        index=indexa;
                      });
                    },
                    child: Image.asset(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(m.homeTeam)].logodir),
                  ),

                ),
              ]),
              Padding(padding: EdgeInsets.all(4)),
              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                // Propagate data down to the widgets that need it
                // The Highlights text has a rounded border
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFFB4B4B4)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                  child: Text(
                    (m.machineHomeScore.toString()+"-"+m.machineAwayScore.toString()),
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
              ]),
              Padding(padding: EdgeInsets.all(4)),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                // Home team logo
                SizedBox(
                  width: 110,
                  height: 110,
                  child:
                  FlatButton(
                    onPressed: () {
                      print('I got clicked');
                    },
                    child: Image.asset(pd.CurrentLeague.Teams[pd.CurrentLeague.getTeamID(m.awayTeam)].logodir),
                  ),

                ),
              ]),
            ]),
          ));
        }}
      currentTeam=pd.CurrentLeague.Teams[team];
      int teamrank=0;
      for(int i=0;i<pd.CurrentLeague.Teams.length;i++){
        if(currentTeam.teamName==pd.CurrentLeague.Teams[i].teamName){teamrank=i;}
      }
      return Center(
        child: new ListView(
            shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
              children: [Center(child:  Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/background2.jpg"
                        ),
                        fit: BoxFit.cover
                    )
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 150,
                  child: Container(
                    alignment: Alignment(0.0,0),
                    child:
                    Image(
                      image: AssetImage(currentTeam.logodir),alignment: Alignment.center,
                    ),


                  ),
                ),
              ) ),
                Center(child: Text(
                  currentTeam.teamName
                  ,style: TextStyle(
                  fontSize: 45.0,
                  color:Colors.black,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold,
                ),
                ),),
                Center(child:  SizedBox(
                  height: 10,
                ),),
                Center(child: Text(


                  "League ranking: "+(pd.CurrentLeague.getTeamIndex(currentTeam)+1).toString()
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),),
                Center(child: SizedBox(
                  height: 5,
                ),),
                Center(child: SizedBox(
                  height: 10,
                ),),
                Center(child:  Text(
                  "Wins: "+currentTeam.win.toString()+" Draws: "+currentTeam.draws.toString()+" Loses: "+currentTeam.loses.toString()
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),),
                Center(child: SizedBox(
                  height: 10,
                ),),
                Center(child:  Text(
                  "Matches:"
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),),
                Center(child:  ListView(

                    shrinkWrap: true,
                    children: teamcont
                )),

        ],
      ));



    }
    if(PageName=="League"){ return Center(
        child: Column(children: <Widget>[

          ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [Column(
                children: <Widget>[

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

                ],
              ),]
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
            Container(
              constraints: BoxConstraints(maxWidth: 100.0, minHeight: 50.0),
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: RaisedButton(
                child: Text("Previous Week"),
                onPressed:  () { setState(() {
                  week-=1;
                  index = (1000*week)+2;
                });
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 100.0, minHeight: 50.0),
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text("Week "+week.toString()),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 100.0, minHeight: 50.0),
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: RaisedButton(
                child: Text("Next Week"),
                onPressed:  () { setState(() {
                  if(week<(pd.CurrentLeague.Teams.length-1)*2){week+=1;}

                  index = (1000*week)+2;
                });
                },
                color: Theme.of(context).accentColor,
              ),
            )])
        ],

        )
    );}
    if(PageName=="Dağhan"){return Column(

      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/background.jpg"
                  ),
                  fit: BoxFit.cover
              )
          ),
          child: Container(
            width: double.infinity,
            height: 200,
            child: Container(
              alignment: Alignment(0.0,2.5),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/Profile.jpg"
                ),
                radius: 60.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Text(
          "Dağhan Sinan"
          ,style: TextStyle(
          fontSize: 45.0,
          color:Colors.green.shade900,
          letterSpacing: 1.0,
          fontWeight: FontWeight.bold,
        ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "İstanbul, Türkiye"
          ,style: TextStyle(
            fontSize: 18.0,
            color:Colors.black45,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w300
        ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "daghansinan@gmail.com"
          ,style: TextStyle(
            fontSize: 18.0,
            color:Colors.black,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w300
        ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "github.com/Nashiria"
          ,style: TextStyle(
            fontSize: 18.0,
            color:Colors.black,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w300
        ),
        ),
      ],
    );}

  }

  Widget bottomNav() {

    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: 60,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int sindex) {
        setState(() {
          index = sindex;
        });
      },
    );
  }


}