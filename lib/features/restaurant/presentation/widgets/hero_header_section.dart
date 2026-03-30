import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeroHeaderSection extends StatelessWidget {
  final String image;
  const HeroHeaderSection({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 300.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.transparent,
                Colors.black.withOpacity(0.6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
