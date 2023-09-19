import 'package:flutter/material.dart';

class CCCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double cardWidth = size.width;
    double cardHeight = cardWidth * 0.4;

    double cardLeft = 0;
    double cardTop = 0;
    double cardRight = cardWidth;
    double cardBottom = cardHeight;

    double cardHoleOffsetLeft = cardWidth * 0.75;
    double cardHoleRadius = 10;

    double roundnessFactorLB = cardWidth * 0.05;
    double roundnessFactorRB = cardWidth * 0.05;
    double roundnessFactorRT = cardWidth * 0.05;
    double roundnessFactorLT = cardWidth * 0.05;

    //
    path.moveTo(cardLeft, cardTop + roundnessFactorLT);

    path.lineTo(cardLeft, cardBottom - roundnessFactorLB);
    path.quadraticBezierTo(cardLeft, cardBottom, roundnessFactorLB, cardBottom);

    path.lineTo(cardHoleOffsetLeft - cardHoleRadius, cardBottom);
    path.arcToPoint(
      Offset(cardHoleOffsetLeft + cardHoleRadius, cardBottom),
      radius: Radius.circular(cardHoleRadius),
      rotation: 180,
    );

    path.lineTo(cardRight - roundnessFactorRB, cardBottom);
    path.quadraticBezierTo(cardRight, cardBottom, cardRight, cardBottom - roundnessFactorRB);


    path.lineTo(cardRight, cardTop + roundnessFactorRT);
    path.quadraticBezierTo(cardRight, cardTop, cardRight - roundnessFactorRT, cardTop);


    path.lineTo(cardHoleOffsetLeft + cardHoleRadius, cardTop);
    path.arcToPoint(
      Offset(cardHoleOffsetLeft - cardHoleRadius, cardTop),
      radius: Radius.circular(cardHoleRadius),
      rotation: 180,
      clockwise: true,
    );


    path.lineTo(cardLeft + roundnessFactorLT, cardTop);
    path.quadraticBezierTo(cardLeft, cardTop, cardLeft, cardTop + roundnessFactorLT);




    // path.fillType = PathFillType.;
    //
    // path.addRRect(
    //     RRect.fromRectAndCorners(
    //       Rect.fromLTRB(0, 0, cardWidth, cardHeight),
    //       topLeft: Radius.circular(roundnessFactor),
    //       topRight: Radius.circular(roundnessFactor),
    //       bottomLeft: Radius.circular(roundnessFactor),
    //       bottomRight: Radius.circular(roundnessFactor),
    //     )
    // );
    //
    // path.addOval(
    //     Rect.fromCircle(
    //         center: Offset(200, 200),
    //         radius: 50,
    //     )
    // );



    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

