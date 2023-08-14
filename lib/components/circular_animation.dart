import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/data_model.dart';

class CircularRevealAnimation extends StatefulWidget {
  final bool isRunning;
  final Duration duration;
  final Size size;
  final Color color;

  CircularRevealAnimation({
    required this.isRunning,
    required this.duration,
    required this.size,
    required this.color,
  });

  @override
  _CircularRevealAnimationState createState() => _CircularRevealAnimationState();
}

class _CircularRevealAnimationState extends State<CircularRevealAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    Provider.of<DataModel>(context, listen: false).addListener(_dataModelListener);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _dataModelListener() {
    if (Provider.of<DataModel>(context, listen: false).isRunning) {
      _controller.forward();
    } else {
      _controller.stop();
    }

    if (Provider.of<DataModel>(context, listen: false).reset) {
      print("circular reset");
      _controller.reset();
      Provider.of<DataModel>(context, listen: false).setReset(false);
      Provider.of<DataModel>(context, listen: false).setPlayingMusic(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double revealProgress = _animation.value;
        double revealSize = widget.size.height;
        double offsetY = revealSize * (1 - revealProgress);

        return ClipOval(
          child: ClipRect(
            clipper: RectClipper(offsetY: offsetY, size: widget.size),
            child: Container(
              width: widget.size.width,
              height: widget.size.height,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RectClipper extends CustomClipper<Rect> {
  final double offsetY;
  final Size size;

  RectClipper({required this.offsetY, required this.size});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, offsetY, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}