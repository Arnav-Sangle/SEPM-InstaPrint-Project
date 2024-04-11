import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  final Function()? onTap;
  final String text;

  const DefaultButton({Key? key, this.onTap, this.text = ''}) : super(key: key);

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.7,
        height: MediaQuery.of(context).size.height / 14,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.grey[200] : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isPressed ? Colors.grey[300]! : Colors.transparent,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.purple,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}