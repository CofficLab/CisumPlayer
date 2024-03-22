import 'package:flutter/material.dart';

class ButtonControl extends StatefulWidget {
  const ButtonControl({super.key, required this.icon, required this.onPressed});

  final Icon icon;
  final void Function() onPressed;

  @override
  State<ButtonControl> createState() => _ButtonControlState();
}

class _ButtonControlState extends State<ButtonControl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0),
      constraints: const BoxConstraints(maxWidth: 60),
      child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
              // backgroundColor: MaterialStateProperty.all(Colors.white70),
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
              iconSize: MaterialStateProperty.all(getButtonSize(context))),
          child: widget.icon),
    );
  }

  double getButtonSize(BuildContext context) {
    if (MediaQuery.of(context).size.width > 800) {
      return 40;
    }

    if (MediaQuery.of(context).size.width > 350) {
      return 40;
    }

    return 40;
  }
}
