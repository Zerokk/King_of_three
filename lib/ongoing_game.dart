import 'package:KingOfThree/ruleset.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class OngoingGame extends StatefulWidget {
  OngoingGame({Key key}) : super(key: key);

  @override
  _OngoingGameState createState() => _OngoingGameState();
}

class _OngoingGameState extends State<OngoingGame> {
  int _diceResult = 0;
  GameRulesManager ruleManager = new GameRulesManager();
  GameRulesNames _ruleToShow;
  String _ruleDescription;
  String _label;
  bool _pressAttention = true;
  int _turns = 0;
  String _status = 'none';
  List<String> _rules = [];
  int duelTry1;
  int duelTry2;
  final _formKey = GlobalKey<FormState>();
  TextEditingController ruleInputController = new TextEditingController();

  void turn() {
    if (_status == 'none') {
      _diceResult = rollDice();
      _ruleToShow = ruleManager.processDiceResult(_diceResult);
    }

    _ruleDescription = ruleManager.getDescriptionForRule(_ruleToShow);
    _label = ruleManager.getLabel(_ruleToShow);
    _turns++;

    _pressAttention = !_pressAttention;

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      // Process rules turn
      if (_ruleToShow == GameRulesNames.CreateRule) {
        _status = 'make_rule';
      }

      // Process rules turn
      if (_ruleToShow == GameRulesNames.Duel) {
        _status = 'duel';
      }
    });
  }

  rollDice() {
    return Random().nextInt(11) + 2;
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
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Configurar partida"),
      ),
      body: SingleChildScrollView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                    top: 20, left: MediaQuery.of(context).size.width * 0.075),
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(80),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: Colors.black)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: Text(
                    "Resultado de la última tirada: ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Roboto", fontSize: 20),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 85),
                  alignment: Alignment.center,
                  child: processResult())
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 25.0),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                _label != null ? "$_label" : '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.only(top: 15.0),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                _label != null ? "$_ruleDescription" : '',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Roboto", fontSize: 14),
              )),
          Visibility(visible: _status == 'none', child: normalDiceButton()),
          Visibility(visible: _status == 'duel', child: duelDiceButton()),
          Visibility(visible: _status == 'make_rule', child: makeRuleInput()),
          Visibility(
            visible: _rules.length > 0 ? true : false,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ListBody(children: getTextWidgets(_rules)),
            ),
          )
        ],
      )),
    );
  }

  List<Widget> getTextWidgets(List<String> strings) {
    List<Widget> list = new List<Widget>();

    list.add(new Text(
      "\nReglas actuales ⚖️",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 22, fontFamily: "Roboto", fontWeight: FontWeight.bold),
    ));

    for (var i = 0; i < strings.length; i++) {
      list.add(new Text(
        "\n[${i + 1}] — " + strings[i],
        style: TextStyle(fontSize: 18),
      ));
    }
    return list;
  }

  Widget normalDiceButton() {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: RaisedButton.icon(
        onPressed: () {
          turn();
        },
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
        color: _pressAttention ? Colors.purple[100] : Colors.blue[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        textColor: Colors.white,
        icon: Image(
          image: AssetImage("assets/images/dice_icon.png"),
          fit: BoxFit.scaleDown,
          width: 40,
          height: 40,
        ),
        label: Text(
          "Tirada de dado",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget duelDiceButton() {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: RaisedButton.icon(
        onPressed: () {
          if (_ruleToShow == GameRulesNames.DuelOnly_SecondPlayerWins ||
              _ruleToShow == GameRulesNames.DuelOnly_FirstPlayerWins ||
              _ruleToShow == GameRulesNames.DuelOnly_DrawSoBothDrink) {
            setState(() {
              _status = 'none';
              duelTry1 = null;
              duelTry2 = null;
              turn();
            });
          } else {
            if (duelTry1 == null) {
              duelTry1 = rollDice();
              _diceResult = duelTry1;
            } else {
              duelTry2 = rollDice();
              _diceResult = duelTry2;
            }

            if (duelTry1 != null && duelTry2 != null) {
              if (duelTry1 > duelTry2) {
                _ruleToShow = GameRulesNames.DuelOnly_FirstPlayerWins;
              } else if (duelTry1 == duelTry2) {
                _ruleToShow = GameRulesNames.DuelOnly_DrawSoBothDrink;
              } else {
                _ruleToShow = GameRulesNames.DuelOnly_SecondPlayerWins;
              }
            }
            turn();
          }
        },
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
        color:
            _pressAttention ? Colors.indigo[400] : Colors.deepOrangeAccent[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        textColor: Colors.white,
        icon: Image(
          image: AssetImage("assets/images/dice_icon.png"),
          fit: BoxFit.scaleDown,
          width: 40,
          height: 40,
        ),
        label: Text(
          duelTry1 == null
              ? "Primera tirada"
              : (duelTry2 == null ? "Segunda tirada" : "Tirada de dado"),
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget makeRuleInput() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 25.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: ruleInputController,
                decoration: const InputDecoration(
                  hintText: 'Introduce tu regla',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return '¡No dejes esto vacío!';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        if (_rules.length == 3) {
                          _rules.removeAt(0);
                        }
                        _rules.add(ruleInputController.value.text.toString());
                        _status = 'none';
                      });
                    }
                  },
                  child: Text('Enviar'),
                ),
              ),
            ],
          ),
        ));
  }

  Widget processResult() {
    if (_status == 'duel' && duelTry1 != null) {
      return Text(
        duelTry2 == null ? "$duelTry1  vs  ..." : "$duelTry1  vs  $duelTry2",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Roboto", fontSize: 70, shadows: [
          Shadow(
              blurRadius: 8,
              color: Colors.grey,
              offset: Offset.fromDirection(7))
        ]),
      );
    } else {
      return Text("$_diceResult",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Roboto", fontSize: 70, shadows: [
            Shadow(
                blurRadius: 8,
                color: Colors.grey,
                offset: Offset.fromDirection(7))
          ]));
    }
  }
}
