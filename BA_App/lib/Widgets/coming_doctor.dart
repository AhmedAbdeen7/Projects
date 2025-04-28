import 'package:flutter/material.dart';
import 'package:ba_app/Screens/Other_Screens/coming_soon.dart';

class ComingDoctor extends StatelessWidget {
  const ComingDoctor({super.key, required this.title});
  // final VoidCallback tap;
  final String title;
  @override
  Widget build(BuildContext context) {
    // return ClipPath(
    //   clipper: CustomShapeClipper(),
    // child:
    // return InkWell(
    //   onTap: tap,
    //   splashColor: Colors.white,
    //   borderRadius: BorderRadius.circular(16),
    // child:

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => const ComingSoon()),
        );
      },
      splashColor: const Color.fromARGB(255, 166, 41, 33),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFFEFEFEF),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(5.0, 4.0),
              blurRadius: 7,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 183, 25, 25),
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      3 * size.width / 4,
      size.height,
      size.width,
      size.height / 2,
    );
    path.lineTo(size.width, 0);
    // path.lineTo(0, size.height);

    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width, 0);
    // path.quadraticBezierTo(size.width * 0.4, size.height * 0.4, size.width, 0);
    // path.lineTo(size.width * 0.9, 0);
    // path.lineTo(size.width, size.height * 0.2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
