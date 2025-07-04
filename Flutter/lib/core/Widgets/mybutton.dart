import 'package:brain_pulse/core/Theming/colors.dart';
import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });
  final String text;
  final void Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // refactor code
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color ?? ColorsApp.primary),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: WidgetStateProperty.all(
          const Size(double.infinity, 55),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyleApp.Button_Style,
      ),
    );

    // code mo alaa :
    //  ElevatedButton(
    //   style: ButtonStyle(
    //       backgroundColor: WidgetStateProperty.all(ColorsApp.blue),
    //       minimumSize:
    //           WidgetStateProperty.all(const Size(double.infinity, 52))),
    //   onPressed: onPressed,
    //   child: Center(
    //     child: Text(
    //       text,
    //       style: TextStyleApp.styletext(16, Colors.white, FontWeight.bold),
    //     ),
    //   ),
    // );
  }
}
