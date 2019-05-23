import 'package:flutter/material.dart';
import 'package:schwarze_sau_app/player.dart';
import 'package:schwarze_sau_app/GameOn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schwarze Sau',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Schwarze Sau'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Player> litems = [];
  final TextEditingController eCtrl = new TextEditingController();

  _addNewPlayer() async {
    if (eCtrl.text.isEmpty) {
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          backgroundColor: Colors.redAccent,
          content: new Text('Players need names!'),
        ),
      );
    } else {
      litems.add(new Player(eCtrl.text, "0", "0"));
      eCtrl.clear();
    }
  }

  Future<Null> _showNewGame() async {
    if (litems.length < 3 || litems.length > 8) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text(
              "Fehler !",
              style: TextStyle(fontSize: 20),
            ),
            content:
                new Text("Es können minimal 3 und maximal 8 Spieler spielen."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close", style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            return new GameOn(litems, dropdownValue);
          },
        ),
      );
    }
  }

  String dropdownValue = '1000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 105,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(20.0),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Starten Sie ein neues Spiel:',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 55,
                    child: TextField(
                      controller: eCtrl,
                      decoration: new InputDecoration(
                        labelText: "Geben Sie den Namen eines Spielers ein:",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      onSubmitted: (text) {
                        _addNewPlayer();
                        setState(() {});
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.black12,
                  ),
                  Expanded(
                      child: new ListView.builder(
                          itemCount: litems.length,
                          itemBuilder: (BuildContext ctxt, int Index) {
                            final item = litems[Index].name;
                            return Dismissible(
                                key: Key(item),
                                background: Container(color: Colors.red),
                                onDismissed: (direction) {
                                  setState(() {
                                    litems.removeAt(Index);
                                  });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("$item dismissed")));
                                },
                                child: SizedBox(
                                    height: 60,
                                    child: Card(
                                        elevation: 2,
                                        color: Colors.blue,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("  " + litems[Index].name,
                                                  style: new TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25.0)),
                                              IconButton(
                                                padding: EdgeInsets.all(0),
                                                color: Colors.white,
                                                onPressed: () => {
                                                      setState(() {
                                                        litems.removeAt(Index);
                                                      })
                                                    },
                                                icon:
                                                    Icon(Icons.delete_forever),
                                              )
                                            ]))));
                          })),
                  Divider(
                    color: Colors.black12,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ' Maximale Punkte',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        new Container(
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                          value: dropdownValue,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['500', '750', '1000', '1500']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )))
                      ]),
                  Divider(
                    color: Colors.black12,
                  ),
                  ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width - 50,
                      child: FlatButton(
                          child: new Text("Neues Spiel",
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 25.0)),
                          color: Colors.blue,
                          padding: EdgeInsets.all(12.0),
                          onPressed: () {
                            _showNewGame();
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12.0))))
                ]),
          ),
        ]),
      ),
      backgroundColor: Colors.white30,
    );
  }
}
