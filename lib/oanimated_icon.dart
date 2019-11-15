import 'package:flutter/material.dart';

class OAnimatedIcon extends StatefulWidget {
  @override
  _OAnimatedIconState createState() => _OAnimatedIconState();
}

class _OAnimatedIconState extends State<OAnimatedIcon>
    with SingleTickerProviderStateMixin {
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
    return FadeTransition(
      opacity: myController,
      child: ScaleTransition(
        scale: Tween(begin: 2.5, end: 1.0).animate(smoothAnimation),
        child: Icon(
          Icons.radio_button_unchecked,
          size: 75,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}

class XAnimatedIcon extends StatefulWidget {
  @override
  _XAnimatedIconState createState() => _XAnimatedIconState();
}

class _XAnimatedIconState extends State<XAnimatedIcon>
    with SingleTickerProviderStateMixin {
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
        child: Icon(
          Icons.close,
          size: 75,
          color: Colors.white,
        ));
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
