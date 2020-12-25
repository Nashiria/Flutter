import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  int score;
  ResultPage({Key key, this.score}) : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState();
}
String FailOrPass(int Score){

  if (Score>=80){

    return 'assets/Success-Stamp.png';
  }
  else{

    return 'assets/Fail-Stamp.png';
  }

}
class _ResultPageState extends State<ResultPage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Result '),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 120,
            backgroundColor: Colors.amber,
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(FailOrPass(widget.score)),
              backgroundColor: Colors.grey,
            ),
          ),
          Divider(
            color: Colors.white30,
            height: 20,
            thickness: 5,
          ),
         Container(
            alignment: Alignment.center,
            child: Text('Your score: ${widget.score}/100',
                style: TextStyle(
                  fontSize: 40,
                )),
          ),
          Divider(
            color: Colors.white30,
            height: 20,
            thickness: 5,
          ),
        ],
      ),
    ]));
  }
}