import 'package:flutter/material.dart';

class AnimatedXIcon extends StatefulWidget {
  @override
  _AnimatedXIconState createState() => _AnimatedXIconState();
}

class _AnimatedXIconState extends State<AnimatedXIcon>
    with SingleTickerProviderStateMixin {
  AnimationController myController;
  @override
  void initState() {
    myController = AnimationController(
        duration: Duration(milliseconds: 500), vsync: this, value: 0.0);
    myController.forward();
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
          Icons.close,
          size: 75,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AnimatedOIcon extends StatefulWidget {
  @override
  _AnimatedOIconState createState() => _AnimatedOIconState();
}

class _AnimatedOIconState extends State<AnimatedOIcon>
    with SingleTickerProviderStateMixin {
  AnimationController myController;
  @override
  void initState() {
    myController = AnimationController(
        duration: Duration(milliseconds: 500), vsync: this, value: 0.0);
    myController.forward();
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
          color: Colors.white,
        ),
      ),
    );
  }
}
