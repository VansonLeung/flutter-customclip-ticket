# flutter-customclip-ticket

![image](https://github.com/VansonLeung/flutter-customclip-ticket/assets/1129695/6af644ce-412c-459a-8647-d688e8dbb538)


## Code breakdown

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_customclipper/src/pages/card/CCCardClipper.dart';

class BoxShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {


    /// Step 0: Preparation
    double cardWidth = size.width;  // card width
    double cardHeight = cardWidth * 0.4;  // card height is card width * 0.4  i.e. horizontal rectangle of ratio 5/2

    double cardLeft = 0;
    double cardTop = 0;
    double cardRight = cardWidth;
    double cardBottom = cardHeight;

    double cardHoleOffsetLeft = cardWidth * 0.75;   // the 2 card holes have the same offset left
    double cardBarcodeOffsetLeft = cardWidth * 0.875;  // the barcode drawings have another offset left
    double cardHoleRadius = cardWidth * 0.025;   //  card hole radius is responsive to card size 

    double roundnessFactorLB = cardWidth * 0.05;  // radius are responsive to card size & individually configurable
    double roundnessFactorRB = cardWidth * 0.05;
    double roundnessFactorRT = cardWidth * 0.05;
    double roundnessFactorLT = cardWidth * 0.05;

    double cardLineStrokeWidth = 2;
    double cardLineDashLength = cardWidth * 0.01;
    double cardLineDashSkip = cardWidth * 0.01;

    double cardBarCodeStrokeWidth = cardWidth * 0.1;


    /// Step 1: Draw ticket bg
    Path path = Path();

    path.moveTo(cardLeft, cardTop + roundnessFactorLT);

    path.lineTo(cardLeft, cardBottom - roundnessFactorLB);
    path.quadraticBezierTo(cardLeft, cardBottom, roundnessFactorLB, cardBottom);


    // Hole
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


    // Hole
    path.lineTo(cardHoleOffsetLeft + cardHoleRadius, cardTop);
    path.arcToPoint(
      Offset(cardHoleOffsetLeft - cardHoleRadius, cardTop),
      radius: Radius.circular(cardHoleRadius),
      rotation: 180,
      clockwise: true,
    );


    path.lineTo(cardLeft + roundnessFactorLT, cardTop);
    path.quadraticBezierTo(cardLeft, cardTop, cardLeft, cardTop + roundnessFactorLT);


    path.close();
    canvas.drawShadow(path, Colors.black, 5.0, false);





    /// Step 2: Draw stroke
    Paint linePaint = Paint();
    linePaint.strokeWidth = cardLineStrokeWidth;
    linePaint.color = const Color.fromARGB(255, 120, 120, 120);

    double dynamicY = cardTop + cardHoleRadius * 1.2;
    double dashHeight = cardLineDashLength;
    double dashSpace = cardLineDashSkip;
    while (dynamicY < cardBottom - cardHoleRadius - dashHeight )
    {
      canvas.drawLine(
          Offset(cardHoleOffsetLeft, dynamicY + dashHeight ),
          Offset(cardHoleOffsetLeft, dynamicY + dashHeight + dashSpace ),
          linePaint
      );

      dynamicY += dashHeight + dashSpace;
    }




    /// Step 3: Draw barcode
    Random rand = Random();
    Paint linePaint2 = Paint();
    linePaint.strokeWidth = cardBarCodeStrokeWidth;
    linePaint.color = const Color.fromARGB(255, 0, 0, 0);

    dynamicY = cardTop + cardHeight * 0.2;
    while (dynamicY < cardBottom - cardHeight * 0.2 )
    {
      var dashHeight = cardWidth * 0.0055 * rand.nextDouble();
      var dashSpace = cardWidth * 0.0055 * rand.nextDouble();
      canvas.drawLine(
          Offset(cardBarcodeOffsetLeft, dynamicY + dashHeight ),
          Offset(cardBarcodeOffsetLeft, dynamicY + dashHeight + dashSpace ),
          linePaint
      );

      dynamicY += dashHeight + dashSpace;
    }

  }




  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class CCCard extends StatelessWidget {
  const CCCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      //定义裁切路径
      clipper: CCCardClipper(),
      child: buildContainer(context),
    );
  }

  //一个普通的背景
  Container buildContainer(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      height: MediaQuery
          .of(context)
          .size
          .width * 0.8 * 1.33,
      //背景装饰
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(
          //渐变使用到的颜色
          colors: [Colors.orange, Colors.deepOrangeAccent],
          //开始位置为右上角
          begin: Alignment.topRight,
          //结束位置为左下角
          end: Alignment.bottomLeft,
        ),
      ),
    );
  }
}

```
