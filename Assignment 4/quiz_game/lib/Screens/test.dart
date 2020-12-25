import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
            appBar: AppBar(
              title: Text('My Contact Info'),
              leading: Icon(Icons.accessibility_new),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.amber,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                ),
                Divider(
                  color: Colors.white30,
                  height: 20,
                  thickness: 5,
                ),
                Text("Name:",
                    style: TextStyle(
                        fontFamily: "Noto_Sans_JP",
                        fontSize: 30,
                        color: Colors.blue[200])),
                Text(
                  "Dağhan Sinan",
                  style: TextStyle(fontFamily: "Noto_Sans_JP", fontSize: 50),
                ),
                Divider(
                  color: Colors.white30,
                  height: 20,
                  thickness: 5,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Image.network(
                        'https://fonts.gstatic.com/s/i/productlogos/gmail_2020q4/v8/web-64dp/logo_gmail_2020q4_color_1x_web_64dp.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("Gmail: "),
                    SizedBox(
                      width: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "daghansinan@gmail.com",
                          style: TextStyle(
                              fontFamily: "Noto_Sans_JP", fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Colors.white30,
                  height: 20,
                  thickness: 5,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Image.asset(
                        'images/boun.jpg',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("Boun: "),
                    SizedBox(
                      width: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "huseyin.sinan@boun.edu.tr",
                          style: TextStyle(
                              fontFamily: "Noto_Sans_JP", fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Colors.white30,
                  height: 20,
                  thickness: 5,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Image.network(
                        'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("Github: "),
                    SizedBox(
                      width: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "github.com/Nashiria",
                          style: TextStyle(
                              fontFamily: "Noto_Sans_JP", fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )));
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}