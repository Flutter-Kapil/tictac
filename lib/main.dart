import 'package:flutter/material.dart';
import 'gameLogic.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

bool changeWinningStatusColor = false;
double endTweenValue = 1.0;

class _TicTacToeState extends State<TicTacToe> with SingleTickerProviderStateMixin {
  Widget getIconFromToken(token t) {
    if (t == token.o) {
      return Icon(
        Icons.radio_button_unchecked,
        size: 75,
        color: Colors.white,
      );
    }
    if (t == token.x) {
      return Icon(
        Icons.close,
        size: 75,
        color: Colors.white,
      );
    } else
      return null;
  }

  Color getColorFromBool(int row, int col) {
    return colorBoard[row][col]
        ? Colors.yellow.withOpacity(0.2)
        : Colors.white30;
  }


  Widget singleExpandedBox(int row, int col) {
    return Expanded(
      child: OneBox(
        buttonChild: getIconFromToken(board[row][col]),
        colors: getColorFromBool(row, col),
        onPressed: () {
          updateBox(row, col);
          setState(() {});
        },
      ),
    );
  }

  Widget expandedRow(int row) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          singleExpandedBox(row, 0),
          singleExpandedBox(row, 1),
          singleExpandedBox(row, 2),
        ],
      ),
    );
  }



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFD6AA7C),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background08.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Tic-Tac-Toe",
                  style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontFamily: 'Quicksand'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: winnerCheck(board)?AnimatedStatus():Text(
                  getCurrentStatus(),
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white.withOpacity(0.6),
                      fontFamily: 'Quicksand'),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  children: <Widget>[
                    expandedRow(0),
                    expandedRow(1),
                    expandedRow(2),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: FlatButton(
                        color: Color(0xFF848AC1),
                        onPressed: () {
                          gameReset();
                          print('test');
                          setState(() {});
                        },
                        child: Text("Reset",
                            style:
                            TextStyle(fontSize: 25, color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateBox(int r, int c) {
    if (legitMove(board[r][c])) {
      board[r][c] = currentPlayer;
      changePlayerIfGameIsNotOver();
    }
  }
}

class OneBox extends StatefulWidget {
  final Widget buttonChild;
  final Function onPressed;
  final Color colors;
  OneBox(
      {this.buttonChild = const Text(''),
        this.onPressed,
        this.colors = Colors.white24});

  @override
  _OneBoxState createState() => _OneBoxState();
}

class _OneBoxState extends State<OneBox> with SingleTickerProviderStateMixin {
  AnimationController myController;

  @override
  void initState() {
    myController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation smoothAnimation =
    CurvedAnimation(parent: myController, curve: Curves.bounceOut);
    return GestureDetector(
      onTap: () {
        widget.onPressed();
        myController.forward();
      },
      child: Container(
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: myController,
          child: ScaleTransition(
              scale: Tween(begin: 2.5, end: 1.0).animate(smoothAnimation),
              child: widget.buttonChild),
        ),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: widget.colors,
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
      ),
    );
  }
}


class AnimatedStatus extends StatefulWidget{
  @override
  _AnimatedStatusState createState() => _AnimatedStatusState();
}

class _AnimatedStatusState extends State<AnimatedStatus> with SingleTickerProviderStateMixin{

  AnimationController myController;
  @override
  void initState() {
    myController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    //add status listener to get blinking effect
    myController.addStatusListener((AnimationStatus buttonAnimationStatus) {
      if (buttonAnimationStatus == AnimationStatus.completed) {
        myController.reverse();
      } else if (buttonAnimationStatus == AnimationStatus.dismissed) {
        myController.forward();
      }
    });
    myController.addListener(() {
      setState(() {});
    });
    myController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation smoothAnimation =
    CurvedAnimation(parent: myController, curve: Curves.bounceIn);
    return Transform.scale(
      scale: Tween(begin: 1.0, end: 2.0).transform(smoothAnimation.value),
      child:Text(getCurrentStatus(),style: TextStyle(fontSize:25,fontFamily: 'Quicksand',color: ColorTween(begin: Colors.white, end: Colors.red).transform(myController.value),),),
    );
  }}