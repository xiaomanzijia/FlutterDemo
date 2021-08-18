//
//  funnel: 漏斗倒计时组件
//  FlutterDemo
//
//  Created by licheng on 2021/8/18 10:21 上午 .
//  Copyright ©2021 FlutterDemo. All rights reserved.
//

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Funnel(),
      ),
    ),
  ));
}

class Funnel extends StatefulWidget {
  final Color color;
  final Duration duration;
  final Curve curve;

  const Funnel(
      {key,
      this.color = Colors.white,
      this.duration = const Duration(milliseconds: 3000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _FunnelState createState() => _FunnelState();
}

class _FunnelState extends State<Funnel> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation, _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.8, curve: widget.curve)));
    _rotateAnimation = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.8, 1.0, curve: widget.curve)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotateAnimation.value,
            child: CustomPaint(
                size: Size(100, 200),
                // foregroundPainter: _ForeGroundPainter(),
                painter:
                    _PouringHourGlassPainter(_animation.value, widget.color)),
          );
        });
  }
}

class _ForeGroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height);
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _ForeGroundPainter oldDelegate) {
    return true;
  }
}

class _PouringHourGlassPainter extends CustomPainter {
  final double progress;
  final Color color;

  Paint _paint;

  final double _middleWidth = 4;

  _PouringHourGlassPainter(this.progress, this.color) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 酒瓶
    var _path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2 + _middleWidth, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2 - _middleWidth, size.height / 2)
      ..close();
    canvas.drawPath(_path, _paint);

    // 上部三角形
    _paint.style = PaintingStyle.fill;
    double _offsetX = progress * (size.width / 2 - _middleWidth);
    var _topTrianglePath = Path()
      ..moveTo(_offsetX, progress * size.height / 2)
      ..lineTo(size.width - _offsetX, progress * size.height / 2)
      ..lineTo(size.width / 2 + _middleWidth, size.height / 2)
      ..lineTo(size.width / 2 - _middleWidth, size.height / 2)
      ..close();
    canvas.drawPath(_topTrianglePath, _paint);

    // 底部三角形
    var _bottomTrianglePath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - _offsetX, size.height - progress * size.height / 2)
      ..lineTo(_offsetX, size.height - progress * size.height / 2)
      ..close();
    canvas.drawPath(_bottomTrianglePath, _paint);

    // 垂直线条
    _paint.style = PaintingStyle.stroke;
    var _linePath = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..lineTo(size.width / 2, size.height - progress * size.height / 2)
      ..close();
    canvas.drawPath(_linePath, _paint);
  }

  @override
  bool shouldRepaint(covariant _PouringHourGlassPainter oldDelegate) {
    return color != oldDelegate.color || progress != oldDelegate.progress;
  }
}
