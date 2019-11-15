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
          Icons.radio_button_unchecked,
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

class XAnimatedIcon extends StatefulWidget {
  @override
  _OAnimatedIconState createState() => _OAnimatedIconState();
}

class _XAnimatedIconState extends State<OAnimatedIcon>
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
