import 'package:flutter/material.dart';

class AnimatedImageCard extends StatefulWidget {
  final String assetPath;
  final double? height;
  final double? width;
  final double heightFactor;
  final Duration delay;
  final Duration duration;
  final BoxFit fit;

  const AnimatedImageCard(
      {super.key,
      required this.assetPath,
      this.height,
      this.width,
      this.heightFactor = 0.35,
      this.delay = Duration.zero,
      this.duration = const Duration(milliseconds: 800),
      this.fit = BoxFit.cover});

  @override
  State<AnimatedImageCard> createState() => _AnimatedImageCardState();
}

class _AnimatedImageCardState extends State<AnimatedImageCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);

    if (widget.delay == Duration.zero) {
      _ctrl.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = widget.height ??
        MediaQuery.of(context).size.height * widget.heightFactor;
    final double width = widget.width ?? double.infinity;

    return ScaleTransition(
      scale: _scale,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(widget.assetPath),
            fit: widget.fit,
          ),
        ),
      ),
    );
  }
}
