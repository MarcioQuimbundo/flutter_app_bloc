import 'package:flutter/material.dart';
import 'dart:async';
import '../login_state.dart';

class ProgressButton extends StatefulWidget {
  final VoidCallback callback;
  final LoginState loginState;
  final double size;

  ProgressButton(this.size, this.loginState, this.callback);

  @override
  State<StatefulWidget> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> with TickerProviderStateMixin {
  bool _isPressed = false, _animatingReveal = false;
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
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: widget.callback != null ? Colors.transparent : Colors.grey,
        elevation: calculateElevation(),
        borderRadius: BorderRadius.circular(widget.size / 2.0),
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.transparent,
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
            color: widget.loginState.token.isNotEmpty ? Colors.green : Colors.blue,
            child: buildButtonChild(),
            onPressed: widget.callback,
            onHighlightChanged: (isPressed) {
              setState(() {
                _isPressed = isPressed;
                if (widget.loginState.isLoginButtonEnabled) {
                  animateButton();
                }
              });
            },
          ),
        ));
  }

  Widget buildButtonChild() {
    if (widget.loginState.loginInitial()) {
      return Text('Login', style: TextStyle(color: Colors.white, fontSize: 16.0));
    } else if (widget.loginState.isLoading) {
      return SizedBox(
        height: 0.75 * widget.size,
        width: 0.75 * widget.size,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else if (widget.loginState.loginSucceeded()) {
      _animatingReveal = true;
      return Icon(Icons.check, color: Colors.white);
    } else {
      return Icon(Icons.clear, color: Colors.red);
    }
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - widget.size) * _animation.value);
        });
      });
    _controller.forward();
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
//    _state = 0;
  }
}
