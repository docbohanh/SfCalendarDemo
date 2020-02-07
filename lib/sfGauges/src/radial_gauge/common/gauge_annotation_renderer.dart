part of gauges;

/// Represents the annotation renderer
///
// ignore: must_be_immutable
class _AnnotationRenderer extends StatefulWidget {
  ///Creates the annotation renderer
  ///
  // ignore: prefer_const_constructors_in_immutables
  _AnnotationRenderer(
      {this.key,
      this.annotation,
      this.gauge,
      this.axis,
      this.interval,
      this.duration})
      : super(
          key: key,
        );

  /// specifies the annotation
  GaugeAnnotation annotation;

  /// Specifies the key annotation renderer
  GlobalKey key;

  /// Specifies the radial gauge
  SfRadialGauge gauge;

  /// Specifies the annotation axis
  RadialAxis axis;

  /// Specifies the interval duration
  List<double> interval;

  /// Specifies the animation duration
  int duration;

  @override
  State<StatefulWidget> createState() {
    return _AnnotationRendererState();
  }
}

/// Represents the annotation renderer state
class _AnnotationRendererState extends State<_AnnotationRenderer>
    with SingleTickerProviderStateMixin {
  /// Holds the animation controller
  AnimationController animationController;

  /// Holds the animation value
  Animation<double> animation;

  @override
  void initState() {
    if (widget.gauge._needsToAnimateAnnotation) {
      animationController = AnimationController(vsync: this)
        ..duration = Duration(milliseconds: widget.duration);
      animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: animationController,
          curve: Interval(widget.interval[0], widget.interval[1],
              curve: Curves.fastOutSlowIn)));
    }
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _calculateAnnotationPosition(context));
  }

  /// Calculates the annotation position based on its size
  void _calculateAnnotationPosition(BuildContext _context) {
    final RenderBox renderBox = _context.findRenderObject();
    setState(() {
      widget.annotation._annotationSize = renderBox.size;
      widget.annotation._opacity = 1;
      widget.annotation._left = widget.annotation._annotationPosition.dx -
          (widget.annotation.horizontalAlignment == GaugeAlignment.near
              ? 0
              : widget.annotation.horizontalAlignment == GaugeAlignment.center
                  ? widget.annotation._annotationSize.width / 2
                  : widget.annotation._annotationSize.width);
      widget.annotation._top = widget.annotation._annotationPosition.dy -
          (widget.annotation.verticalAlignment == GaugeAlignment.near
              ? 0
              : widget.annotation.verticalAlignment == GaugeAlignment.center
                  ? widget.annotation._annotationSize.height / 2
                  : widget.annotation._annotationSize.height);
    });
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController
          .dispose(); // Need to dispose the animation controller instance otherwise it will cause memory leak
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gauge._needsToAnimateAnnotation) {
      animationController.forward(from: 0);
      return Positioned(
          left: widget.annotation._left,
          top: widget.annotation._top,
          child: AnimatedBuilder(
              animation: animationController,
              child: widget.annotation.widget,
              builder: (BuildContext context, Widget _widget) {
                _updateAnimation();
                return Opacity(
                    opacity: widget.annotation._opacity * animation.value,
                    child: widget.annotation.widget);
              }));
    } else {
      return Positioned(
          left: widget.annotation._left,
          top: widget.annotation._top,
          child: Opacity(
              opacity: widget.annotation._isOldAnnotation
                  ? 1
                  : widget.annotation._opacity,
              child: widget.annotation.widget));
    }
  }

  /// To update the animation of annotation
  void _updateAnimation() {
    if (widget.gauge.axes[widget.gauge.axes.length - 1] == widget.axis &&
        widget.axis.annotations[widget.axis.annotations.length - 1] ==
            widget.annotation &&
        animation.value == 1) {
      widget.gauge._needsToAnimateAnnotation = false;
    }
  }
}
