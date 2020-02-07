part of gauges;

/// Represents the painter to render the needle pointer
class _NeedlePointerPainter extends CustomPainter {
  /// Creates the needle pointer painter
  _NeedlePointerPainter(this._gauge, this._axis, this._needlePointer,
      this._isRepaint, this._pointerAnimation, ValueNotifier<num> notifier)
      : super(repaint: notifier);

  /// Specifies the circular gauge
  final SfRadialGauge _gauge;

  /// Specifies the gauge axis
  final RadialAxis _axis;

  /// Specifies the needle pointer
  final NeedlePointer _needlePointer;

  /// Specifies whether to redraw the pointer
  final bool _isRepaint;

  /// Specifies the animation value of needle pointer
  final Animation<double> _pointerAnimation;

  @override
  void paint(Canvas canvas, Size size) {
    double _angle;
    bool _needsShowPointer;
    final bool _needsPointerAnimation =
        _needlePointer._isPointerAnimationEnabled();
    if (_pointerAnimation != null) {
      _needsShowPointer = _axis.isInversed
          ? _pointerAnimation.value < 1
          : _pointerAnimation.value > 0;
    }

    if (_gauge._needsToAnimatePointers || _needsPointerAnimation) {
      if ((_gauge._needsToAnimatePointers && _needsShowPointer) ||
          !_gauge._needsToAnimatePointers) {
        _angle = (_axis._sweepAngle * _pointerAnimation.value) +
            _axis.startAngle +
            90; //Since the needle rect has been calculated with -90 degree, additional 90 degree is added
      }
    } else {
      _angle = _needlePointer._angle +
          90; //Since the needle rect has been calculated with -90 degree, additional 90 degree is added
    }
    final Offset startPosition =
        Offset(_needlePointer._startX, _needlePointer._startY);
    final Offset endPosition =
        Offset(_needlePointer._stopX, _needlePointer._stopY);
    final double _animationValue =
        _needsPointerAnimation ? _pointerAnimation.value : null;

    if (_angle != null) {
      _needlePointer.drawPointer(
          canvas, _animationValue, startPosition, endPosition, _angle);
    }

    final bool _isPointerEndAngle = _isEndAngle(_angle);
    if (_needsPointerAnimation && _isPointerEndAngle) {
      _needlePointer._needsAnimate = false;
    }

    if (_gauge._needsToAnimatePointers &&
        _gauge.axes[_gauge.axes.length - 1] == _axis &&
        _axis.pointers[_axis.pointers.length - 1] == _needlePointer &&
        _isPointerEndAngle) {
      _gauge._needsToAnimatePointers = false;
    }
  }

  /// Checks whether the current angle is pointer end angle
  bool _isEndAngle(double _angle) {
    return _angle ==
        _axis._sweepAngle * _needlePointer._animationEndValue +
            _axis.startAngle +
            90;
  }

  @override
  bool shouldRepaint(_NeedlePointerPainter oldDelegate) => _isRepaint;
}
