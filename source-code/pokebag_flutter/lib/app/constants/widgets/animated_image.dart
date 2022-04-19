import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedImage extends StatefulWidget {
  final String images;

  const AnimatedImage({Key? key, required this.images}) : super(key: key);

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  /// This will be a animation controller on an object.
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000))
    ..repeat(reverse: true);

  /// Configures object's animation.
  late final Animation<Offset> _animation =
      Tween(begin: const Offset(0, -1.2), end: Offset.zero).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.bounceOut));

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String templateAssetImageDir = 'assets/images/';

    return SlideTransition(
      position: _animation,
      child: SvgPicture.asset(templateAssetImageDir + widget.images),
    );
  }
}
