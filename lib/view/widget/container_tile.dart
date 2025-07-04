import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tile extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  final Duration delay;
  const Tile(
      {super.key,
      required this.icon,
      required this.color,
      required this.title,
      required this.delay});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: delay,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(100),
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon),
            SizedBox(width: 3),
            Text(
              title,
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
      ),
    );
  }
}
