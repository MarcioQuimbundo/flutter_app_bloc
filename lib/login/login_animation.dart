import 'package:flutter/material.dart';
import 'dart:async';

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.buttonController})
      : buttonSqueezeAnimation = new Tween(
          begin: 320.0,
          end: 70.0,
        ).animate(new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.0,
              0.150,
            ))),
        buttonZoomOut = new Tween(
          begin: 70.0,
          end: 1000.0,
        ).animate(new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(0.550, 0.999, curve: Curves.bounceOut))),
        containerCircleAnimation = new EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 50.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(0.500, 0.800, curve: Curves.ease))),
        super(key: key);

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeAnimation;
  final Animation buttonZoomOut;

  @override
  Widget build(BuildContext context) {
    buttonController.addListener(() {
      if (buttonController.isCompleted) {
        Navigator.pushNamed(context, "/home");
      }
    });
    return new AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }

  Widget _buildAnimation(BuildContext, Widget child) {
    return new Padding(
      padding: buttonZoomOut.value == 70
          ? const EdgeInsets.only(bottom: 50.0)
          : containerCircleAnimation.value,
      child: new InkWell(
          onTap: () {
            _playAnimation();
          },
          child: new Hero(
            tag: "fade",
            child: buttonZoomOut.value <= 300
                ? new Container(
                    width: buttonZoomOut.value == 70
                        ? buttonSqueezeAnimation.value
                        : buttonZoomOut.value,
                    height:
                        buttonZoomOut.value == 70 ? 60.0 : buttonZoomOut.value,
                    alignment: FractionalOffset.center,
                    decoration: new BoxDecoration(
                        color: const Color.fromRGBO(247, 64, 106, 1.0),
                        borderRadius: buttonZoomOut.value < 400
                            ? new BorderRadius.all(const Radius.circular(30.0))
                            : new BorderRadius.all(const Radius.circular(0.0))),
                    child: buttonSqueezeAnimation.value > 75.0
                        ? new Text(
                            "Sign In",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.3,
                            ),
                          )
                        : buttonZoomOut.value < 300.0
                            ? new CircularProgressIndicator(
                                value: null,
                                strokeWidth: 1.0,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              )
                            : null)
                : new Container(
                    width: buttonZoomOut.value,
                    height: buttonZoomOut.value,
                    decoration: new BoxDecoration(
                      shape: buttonZoomOut.value < 500
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      color: const Color.fromRGBO(247, 64, 106, 1.0),
                    ),
                  ),
          )),
    );
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController.forward();
      await buttonController.reverse();
    } on TickerCanceled {}
  }
}
