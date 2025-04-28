import 'package:flutter/material.dart';
import 'constants.dart';

class BlueButton extends StatelessWidget {
  final String teks;
  final double padding;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const BlueButton({
    Key? key,
    required this.teks,
    required this.padding,
    required this.onPressed,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDD0C0C),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: borderRadiusStd),
        ),
        onPressed: onPressed,
        child: Text(teks, style: textStyle),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'constants.dart';

// class BlueButton extends StatelessWidget {
//   final String teks;
//   final double padding;
//   final VoidCallback onPressed;

//   const BlueButton({
//     Key? key,
//     required this.teks,
//     required this.padding,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(padding),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFDD0C0C),
//           foregroundColor: Colors.white,
//           minimumSize: const Size(double.infinity, 50),
//           shape: RoundedRectangleBorder(
//             borderRadius: borderRadiusStd,
//           ),
//         ),
//         onPressed: onPressed,
//         child: Text(teks),
//       ),
//     );
//   }
// }
