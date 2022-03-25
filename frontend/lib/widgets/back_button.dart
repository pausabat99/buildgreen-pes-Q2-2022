import 'package:flutter/material.dart';
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.teal.withAlpha(0),
        onPrimary: Colors.white.withAlpha(0),
        shadowColor: Colors.black.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        side: const BorderSide(
          color: Colors.white,
          width: 3,
        ),
        elevation: 1
      ),
      onPressed: () => {Navigator.pop(context)},
      child: const Icon(
        Icons.arrow_back_rounded,
        color: Colors.white,
        size: 45,),
    );
  }
}