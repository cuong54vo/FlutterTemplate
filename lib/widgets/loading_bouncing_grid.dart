import 'package:flutter/material.dart';

/// Creates a loading animation grid with nine shapes that bounces diagonally
class LoadingBouncingGrid extends StatefulWidget {
  /// Sets an [AnimationController] in case you need to do something
  /// specific with it like play/pause animation.
  final AnimationController? controller;

  final BoxShape _shape;

  /// The color of the shape itself.
  ///
  /// Default color is set to [Colors.blueGrey].
  final Color backgroundColor;

  /// The color of the border of the shape.
  ///
  /// Default color is set to [Colors.transparent].
  final Color borderColor;

  /// Size of the whole square containing the animation.
  ///
  /// Default size is set to [50].
  final double size;

  /// Size of the border of each shape in the grid.
  ///
  /// Default size is set to [size/24].
  final double? borderSize;

  /// Sets the animation to be inverted.
  ///
  /// Default value is set to [false].
  final bool inverted;

  /// Total duration for one cycle of animation.
  ///
  /// Default value is set to [Duration(milliseconds: 1500)].
  final Duration duration;

  /// Sets an [IndexedWidgetBuilder] function to return
  /// your own customized widget.
  final IndexedWidgetBuilder? itemBuilder;

  /// Creates the LoadingBouncingGrid animation with a circle shape.
  LoadingBouncingGrid.circle({
    Key? key,
    this.controller,
    this.backgroundColor = Colors.blueGrey,
    this.borderColor = Colors.transparent,
    this.size = 50.0,
    this.borderSize,
    this.inverted = false,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1500),
  })  : assert(backgroundColor != null,
            'loading_animations: property [backgroundColor] must not be null. Prefer using Colors.transparent instead.'),
        assert(borderColor != null,
            'loading_animations: property [borderColor] must not be null. Prefer using Colors.transparent instead.'),
        assert(size > 0,
            'loading_animations: property [size] must be greater than 0'),
        assert(borderSize != null ? borderSize <= size / 2 : true,
            'loading_animations: property [borderSize] must not be greater than half the widget size'),
        assert(duration.inMilliseconds > 0,
            'loading_animations: property [duration] must be greater than 0'),
        _shape = BoxShape.circle,
        super(key: key);

  /// Creates the LoadingBouncingGrid animation with a square shape.
  LoadingBouncingGrid.square({
    Key? key,
    this.controller,
    this.backgroundColor = Colors.blueGrey,
    this.borderColor = Colors.transparent,
    this.size = 50.0,
    this.borderSize,
    this.inverted = false,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1500),
  })  : assert(backgroundColor != null,
            'loading_animations: property [backgroundColor] must not be null. Prefer using Colors.transparent instead.'),
        assert(borderColor != null,
            'loading_animations: property [borderColor] must not be null. Prefer using Colors.transparent instead.'),
        assert(size > 0,
            'loading_animations: property [size] must be greater than 0'),
        assert(borderSize != null ? borderSize <= size / 2 : true,
            'loading_animations: property [borderSize] must not be greater than half the widget size'),
        assert(duration.inMilliseconds > 0,
            'loading_animations: property [duration] must be greater than 0'),
        _shape = BoxShape.rectangle,
        super(key: key);

  @override
  _LoadingBouncingGridState createState() => _LoadingBouncingGridState();
}

class _LoadingBouncingGridState extends State<LoadingBouncingGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1, _animation2, _animation3, _animation4, _animation5;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AnimationController(vsync: this, duration: widget.duration);

    _animation1 = _createAnimation(0.0, 0.6);
    _animation2 = _createAnimation(0.1, 0.7);
    _animation3 = _createAnimation(0.2, 0.8);
    _animation4 = _createAnimation(0.3, 0.9);
    _animation5 = _createAnimation(0.4, 1.0);

    _controller
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  Animation<double> _createAnimation(double start, double end) {
    return Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(widget.size),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildShape(_animation3, 0),
              _buildShape(_animation4, 1),
              _buildShape(_animation5, 2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildShape(_animation2, 3),
              _buildShape(_animation3, 4),
              _buildShape(_animation4, 5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildShape(_animation1, 6),
              _buildShape(_animation2, 7),
              _buildShape(_animation3, 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShape(Animation<double> animation, int index) {
    final invertedOffset = widget.inverted ? 1 : 0;
    return Transform.scale(
      scale: invertedOffset - animation.value.abs(),
      child: _itemBuilder(index),
    );
  }

  Widget _itemBuilder(int index) {
    return SizedBox.fromSize(
      size: Size.square(widget.size / 3),
      child: widget.itemBuilder != null
          ? widget.itemBuilder!(context, index)
          : DecoratedBox(
              decoration: BoxDecoration(
                shape: widget._shape,
                color: widget.backgroundColor,
                border: Border.all(
                  color: widget.borderColor,
                  width: widget.borderSize != null
                      ? widget.borderSize! / 3
                      : widget.size / 24,
                  style: BorderStyle.solid,
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
