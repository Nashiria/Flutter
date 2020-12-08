import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double result = 0.0;
  bool point = false;
  bool div = false;
  bool add = false;
  bool mult = false;
  bool subs = false;
  int pointcount = 0;
  double firstnum = 0;
  bool pointfirstdec = true;
  double lastres = 0;
  List last = [];
  void onDigitPress(int digit) {
    last.add(result);
    if (!point) {
      int numbe = result.toInt();
      int length = numbe.toString().length;
      double afterpoint = result - numbe;
      result = (numbe * 10) + digit + afterpoint;
    } else {
      pointcount += 1;
      String res = result.toString();
      String dig = digit.toString();
      if (pointcount == 1) {
        String res = result.toString();
        int num = result.toInt();
        double resx = num + digit * 1 / 10;
        result = resx;
      } else {
        String res = result.toString();
        result = double.parse(res + dig);
      }
    }

    refresh();
  }

  void onPointPress() {
    point = true;

    pointcount = 0;
    refresh();
  }

  void onOperate(String operator) {
    point = false;
    pointcount = 0;
    if (operator == "/") {
      div = true;
      firstnum = result;
      result = 0;
    }
    if (operator == "*") {
      mult = true;
      firstnum = result;
      result = 0;
    }
    if (operator == "-") {
      subs = true;
      firstnum = result;
      result = 0;
    }
    if (operator == "+") {
      add = true;
      firstnum = result;
      result = 0;
    }
    refresh();
  }

  void calcres() {
    point = false;
    if (add == true) {
      add = false;
      result += firstnum;
    }
    if (div == true) {
      div = false;
      result = firstnum / result;
    }
    if (subs == true) {
      subs = false;
      result = firstnum - result;
    }
    if (mult == true) {
      mult = false;
      result = firstnum * result;
    }
    refresh();
  }

  void clear() {
    point = false;
    result = 0;
    refresh();
  }

  void delete() {
    if (last.length > 0) {
      result = last[last.length - 1];
      last.removeLast();
    } else {
      result = 0;
    }
    refresh();
  }

  void refresh() {
    setState(() {
      result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text("$result",
                    style: TextStyle(
                      fontSize: 40,
                    )),
              ),
            ),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: RaisedButton(
                      color: Colors.red,
                      onPressed: () {
                        clear();
                      },
                      child: Text("C")),
                ),
                Expanded(
                    child: RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    delete();
                  },
                  child: Text("Delete"),
                )),
                Expanded(
                  child: RaisedButton(
                      color: Colors.orange[400],
                      onPressed: () {
                        onOperate("/");
                      },
                      child: Text("/")),
                ),
              ],
            )),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: RaisedButton(
                      color: Colors.blue[100],
                      onPressed: () {
                        onDigitPress(7);
                      },
                      child: Text("7")),
                ),
                Expanded(
                  child: RaisedButton(
                      color: Colors.blue[100],
                      onPressed: () {
                        onDigitPress(8);
                      },
                      child: Text("8")),
                ),
                Expanded(
                  child: RaisedButton(
                      color: Colors.blue[100],
                      onPressed: () {
                        onDigitPress(9);
                      },
                      child: Text("9")),
                ),
                Expanded(
                  child: RaisedButton(
                      color: Colors.orange[400],
                      onPressed: () {
                        onOperate("*");
                      },
                      child: Text("x")),
                ),
              ],
            )),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: RaisedButton(
                      color: Colors.blue[100],
                      onPressed: () {
                        onDigitPress(4);
                      },
                      child: Text("4")),
                ),
                Expanded(
                  child: RaisedButton(
                      color: Colors.blue[100],
                      onPressed: () {
                        onDigitPress(5);
                      },
                      child: Text("5")),
                ),
                Expanded(
                  child: RaisedButton(
                      color: Colors.blue[100],
                      onPressed: () {
                        onDigitPress(6);
                      },
                      child: Text("6")),
                ),
                Expanded(
                  child: RaisedButton(
                      color: Colors.orange[400],
                      onPressed: () {
                        onOperate("+");
                      },
                      child: Text("+")),
                ),
              ],
            )),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: RaisedButton(
                      color: Colors.blue[100],
                      onPressed: () {
                        onDigitPress(1);
                      },
                      child: Text("1")),
                ),
                Expanded(
                  child: RaisedButton(
                      color: Colors.blue[100],
                      onPressed: () {
                        onDigitPress(2);
                      },
                      child: Text("2")),
                ),
                Expanded(
                  child: RaisedButton(
                      color: Colors.blue[100],
                      onPressed: () {
                        onDigitPress(3);
                      },
                      child: Text("3")),
                ),
                Expanded(
                  child: RaisedButton(
                      color: Colors.orange[400],
                      onPressed: () {
                        onOperate("-");
                      },
                      child: Text("-")),
                ),
              ],
            )),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: RaisedButton(
                        color: Colors.blue[100],
                        onPressed: () {
                          onPointPress();
                        },
                        child: Text(".")),
                  ),
                  Expanded(
                    child: RaisedButton(
                        color: Colors.blue[100],
                        onPressed: () {
                          onDigitPress(0);
                        },
                        child: Text("0")),
                  ),
                  Expanded(
                    child: RaisedButton(
                        color: Colors.blue[100],
                        onPressed: () {
                          onDigitPress(0);
                          onDigitPress(0);
                        },
                        child: Text("00")),
                  ),
                  Expanded(
                    child: RaisedButton(
                        color: Colors.orange[400],
                        onPressed: () {
                          calcres();
                        },
                        child: Text("=")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
