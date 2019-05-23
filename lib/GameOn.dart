import 'package:flutter/material.dart';
import 'package:schwarze_sau_app/player.dart';

class GameOn extends StatefulWidget {
  final List<Player> litems;
  final String dropDownValue;

  @override
  _GameOnState createState() => new _GameOnState(this.litems, this.dropDownValue);

  GameOn(this.litems, this.dropDownValue);
}

class _GameOnState extends State<GameOn> {
  final List<Player> litems;
  final String dropDownValue;

  _GameOnState(this.litems, this.dropDownValue);

  BuildContext scaffoldContext;

  var showedString = "0";
  var actualPlayer = "Test";
  var actualIndex = 0;
  var actualRound = "1";
  var actualRest = "220";

  Widget _button(String number, Function() f) {
    // Creating a method of return type Widget with number and function f as a parameter
    return MaterialButton(
      height: MediaQuery.of(context).size.height / 10,
      minWidth: MediaQuery.of(context).size.width / 3,
      child: Text(number,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
      textColor: Colors.white,
      color: Colors.blue,
      onPressed: f,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Game On'),
        backgroundColor: Colors.blue,
      ),
      body: new Builder(builder: (BuildContext context) {
        scaffoldContext = context;
        actualPlayer = litems[actualIndex].name;

        return new Container(
            color: Colors.black38,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                    Row(children: <Widget>[
                  SizedBox(
                      height: 75,
                      width: MediaQuery.of(context).size.width / 2,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.black54),
                        child: Center(
                            child: Text(
                          "$actualPlayer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )),
                      )),
                  SizedBox(
                      height: 75,
                      width: MediaQuery.of(context).size.width / 2,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.black54),
                        child: Center(
                            child: Text(
                          "Runde: $actualRound",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )),
                      )),
                ]),
                Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).size.height - 80 - 85 - (MediaQuery.of(context).size.height / 10) * 5 ,
                            width: MediaQuery.of(context).size.width / 2,
                            child: DecoratedBox(
                              decoration:
                                  const BoxDecoration(color: Colors.black54),
                              child: Center(
                                  child: Text(
                                "$showedString",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold),
                              )),
                            )),
                        SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.width / 2,
                            child: DecoratedBox(
                              decoration:
                                  const BoxDecoration(color: Colors.black54),
                              child: Center(
                                  child: Text(
                                "Rest: $actualRest",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              )),
                            )),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height - 90 - (MediaQuery.of(context).size.height / 10) * 5,
                        width: MediaQuery.of(context).size.width / 2,
                        child: new ListView.builder(
                            itemCount: litems.length,
                            itemBuilder: (BuildContext ctxt, int Index) {
                              return SizedBox(
                                  height: 60,
                                  child: Card(
                                      elevation: 2,
                                      color: Colors.black38,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("  " + litems[Index].name,
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(litems[Index].points + "   ",
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ])));
                            })),

                ],
                ),
                Container(
                    child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _button("9", _nine),
                        _button("8", _eight),
                        _button("7", _seven)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _button("6", _six),
                        _button("5", _five),
                        _button("4", _four)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _button("3", _three),
                        _button("2", _two),
                        _button("1", _one)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _button("C", _clean),
                        _button("0", _zero),
                        _button("OK", _enter)
                      ],
                    ),
                  ],
                )),
              ],
            ));
      }),
    );
  }

  _zero() {
    setState(() {
      if (showedString.length == 3) {
        Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: new Text(
              "Zu große Zahl!",
              style: TextStyle(fontSize: 18),
            )));
        return;
      }
      if (showedString.length == 1 && showedString == "0") {
        showedString = "0";
      } else {
        showedString += "0";
      }
    });
  }

  _one() {
    setState(() {
      if (showedString.length == 3) {
        Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: new Text(
              "Zu große Zahl!",
              style: TextStyle(fontSize: 18),
            )));
        return;
      }
      if (showedString.length == 1 && showedString == "0") {
        showedString = "1";
      } else {
        showedString += "1";
      }
    });
  }

  _two() {
    setState(() {
      if (showedString.length == 3) {
        Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: new Text(
              "Zu große Zahl!",
              style: TextStyle(fontSize: 18),
            )));
        return;
      }
      if (showedString.length == 1 && showedString == "0") {
        showedString = "2";
      } else {
        showedString += "2";
      }
    });
  }

  _three() {
    setState(() {
      if (showedString.length == 3) {
        Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: new Text(
              "Zu große Zahl!",
              style: TextStyle(fontSize: 18),
            )));
        return;
      }
      if (showedString.length == 1 && showedString == "0") {
        showedString = "3";
      } else {
        showedString += "3";
      }
    });
  }

  _four() {
    setState(() {
      if (showedString.length == 3) {
        Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: new Text(
              "Zu große Zahl!",
              style: TextStyle(fontSize: 18),
            )));
        return;
      }
      if (showedString.length == 1 && showedString == "0") {
        showedString = "4";
      } else {
        showedString += "4";
      }
    });
  }

  _five() {
    setState(() {
      if (showedString.length == 3) {
        Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: new Text(
              "Zu große Zahl!",
              style: TextStyle(fontSize: 18),
            )));
        return;
      }
      if (showedString.length == 1 && showedString == "0") {
        showedString = "5";
      } else {
        showedString += "5";
      }
    });
  }

  _six() {
    setState(() {
      if (showedString.length == 3) {
        Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: new Text(
              "Zu große Zahl!",
              style: TextStyle(fontSize: 18),
            )));
        return;
      }
      if (showedString.length == 1 && showedString == "0") {
        showedString = "6";
      } else {
        showedString += "6";
      }
    });
  }

  _seven() {
    setState(() {
      if (showedString.length == 3) {
        Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: new Text(
              "Zu große Zahl!",
              style: TextStyle(fontSize: 18),
            )));
        return;
      }
      if (showedString.length == 1 && showedString == "0") {
        showedString = "7";
      } else {
        showedString += "7";
      }
    });
  }

  _eight() {
    setState(() {
      if (showedString.length == 3) {
        Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: new Text(
              "Zu große Zahl!",
              style: TextStyle(fontSize: 18),
            )));
        return;
      }
      if (showedString.length == 1 && showedString == "0") {
        showedString = "8";
      } else {
        showedString += "8";
      }
    });
  }

  _nine() {
    setState(() {
      if (showedString.length == 3) {
        Scaffold.of(scaffoldContext).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: new Text(
              "Zu große Zahl!",
              style: TextStyle(fontSize: 18),
            )));
        return;
      }
      if (showedString.length == 1 && showedString == "0") {
        showedString = "9";
      } else {
        showedString += "9";
      }
    });
  }

  _clean() {
    setState(() {
      showedString = "0";
    });
  }

  _enter() {
    int oldPoints = int.parse(litems[actualIndex].points);
    int newPoints = int.parse(showedString);

    setState(() {
      litems[actualIndex].points = (oldPoints + newPoints).toString();
    });

    if(int.parse(litems[actualIndex].points) >= int.parse(dropDownValue)){
      showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text("Spieler "+actualPlayer+" hat verloren !"),
            actions: <Widget>[
              new FlatButton(onPressed: () => Navigator.pop(context), child: new Text('Ok'))
            ],
          )
          );
    }

    actualPlayer = litems[actualIndex].name;
    actualRest = (int.parse(actualRest) - newPoints).toString();
    if (actualIndex == litems.length - 1) {
      actualRound = (int.parse(actualRound) + 1).toString();
      actualIndex = 0;
      actualRest = "220";
    } else {
      actualIndex += 1;
    }
    showedString = "0";
  }
}
