import 'package:flutter/material.dart';
import 'dart:async';

class ProgressButton extends StatefulWidget {
//  final Function callback;
  double size;

  ProgressButton(this.size);

//  ProgressButton(this.callback);

  @override
  State<StatefulWidget> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  bool _isPressed = false, _animatingReveal = false;
  int _state = 0;
  double _width = double.infinity;
  Animation _animation;
  GlobalKey _globalKey = GlobalKey();
  AnimationController _controller;

  @override
  void deactivate() {
    reset();
    super.deactivate();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: _state == 2 ? Colors.green : Colors.blue,
        elevation: calculateElevation(),
        borderRadius: BorderRadius.circular(widget.size / 2.0),
        child: Container(
          key: _globalKey,
          height: widget.size,
          width: _width,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(widget.size / 2.0),
            border: new Border.all(
              width: 0.0,
              color: Colors.transparent,
            ),
          ),
          child: FlatButton(
            padding: EdgeInsets.all(0.0),
            color: Colors.transparent,
            child: buildButtonChild(),
            onPressed: () {},
            onHighlightChanged: (isPressed) {
              setState(() {
                _isPressed = isPressed;
                if (_state == 0) {
                  animateButton();
                }
              });
            },
          ),
        ));
  }

  Widget buildButtonChild() {
    if (_state == 0) {
      return Text('Login',
          style: TextStyle(color: Colors.white, fontSize: 16.0));
    } else if (_state == 1) {
      return SizedBox(
        height: 0.75 * widget.size,
        width: 0.75 * widget.size,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _width =
              initialWidth - ((initialWidth - widget.size) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });

    Timer(Duration(milliseconds: 3600), () {
      _animatingReveal = true;
//      widget.callback();
    });
  }

  double calculateElevation() {
    if (_animatingReveal) {
      return 0.0;
    } else {
      return _isPressed ? 6.0 : 4.0;
    }
  }

  void reset() {
    _width = double.infinity;
    _animatingReveal = false;
    _state = 0;
  }
}
