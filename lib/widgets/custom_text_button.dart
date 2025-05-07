import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  
  const CustomTextButton({
    super.key, 
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFFFFFFFF),
            side: BorderSide(
                color: Color(0xFFE8ECFD),
                width: 4
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: text != null
                  ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          text!,
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                    ),
                  )
                  : Text('')
    );
  }
}