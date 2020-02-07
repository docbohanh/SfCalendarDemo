part of gauges;

/// Represents the painter to draw marker
class _MarkerPointerPainter extends CustomPainter {
  _MarkerPointerPainter(
    this._gauge,
    this._axis,
    this._markerPointer,
    this._isRepaint,
    this._pointerAnimation,
    ValueNotifier<num> notifier,
  ) : super(repaint: notifier);

  /// Specifies the circular gauge
  final SfRadialGauge _gauge;

  /// Specifies whether to repaint the series
  final bool _isRepaint;

  /// Specifies the axis of the painter
  final RadialAxis _axis;

  /// Specifies the marker pointer
  final MarkerPointer _markerPointer;

  /// Specifies the pointer animation
  final Animation<double> _pointerAnimation;

  Offset _offset;

  @override
  void paint(Canvas canvas, Size size) {
    double _markerAngle = 0;
    final bool _needsPointerAnimation =
        _markerPointer._isPointerAnimationEnabled();
    bool _needsShowPointer;
    if (_pointerAnimation != null) {
      _needsShowPointer = _axis.isInversed
          ? _pointerAnimation.value < 1
          : _pointerAnimation.value > 0;
    }

    if (_gauge._needsToAnimatePointers || _needsPointerAnimation) {
      if ((_gauge._needsToAnimatePointers && _needsShowPointer) ||
          !_gauge._needsToAnimatePointers) {
        _markerAngle =
            (_axis._sweepAngle * _pointerAnimation.value) + _axis.startAngle;
        _offset = _markerPointer
            ._calculateMarkerOffset(_degreeToRadian(_markerAngle));
      }
    } else {
      _offset = _markerPointer._offset;
      _markerAngle = _markerPointer._angle;
    }

    final double _animationValue =
        _needsPointerAnimation ? _pointerAnimation.value : null;

    if (_offset != null) {
      _markerPointer.drawPointer(
          canvas, _animationValue, _offset, _offset, _markerAngle);
    }

    if (_needsPointerAnimation &&
        _markerAngle ==
            _axis._sweepAngle * _markerPointer._animationEndValue +
                _axis.startAngle) {
      _markerPointer._needsAnimate = false;
    }

    if (_gauge._needsToAnimatePointers &&
        _gauge.axes[_gauge.axes.length - 1] == _axis &&
        _axis.pointers[_axis.pointers.length - 1] == _markerPointer &&
        _markerAngle ==
            _axis._sweepAngle * _markerPointer._animationEndValue +
                _axis.startAngle) {
      _gauge._needsToAnimatePointers = false;
    }
  }

  @override
  bool shouldRepaint(_MarkerPointerPainter oldDelegate) => _isRepaint;
}
