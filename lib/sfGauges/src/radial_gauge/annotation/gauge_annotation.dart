part of gauges;

/// Represents the gauge annotation.
///
/// ```dart
/// Widget build(BuildContext context) {
///    return Container(
///        child: SfRadialGauge(
///          axes:<RadialAxis>[RadialAxis(
///            annotations: <GaugeAnnotation>[
///            GaugeAnnotation(widget: Text('Annotation'))
///            ]
///            )]
///        ));
///}
/// ```
class GaugeAnnotation {
  GaugeAnnotation(
      {this.widget,
      this.axisValue,
      this.horizontalAlignment = GaugeAlignment.center,
      this.angle,
      this.verticalAlignment = GaugeAlignment.center,
      this.positionFactor = 0})
      : assert(positionFactor != null),
        assert(positionFactor >= 0) {
    _opacity = 0;
    _left = 0;
    _top = 0;
    _isOldAnnotation = false;
  }

  /// Specifies the annotation widget.
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///            annotations: <GaugeAnnotation>[
  ///            GaugeAnnotation(widget: Text('Annotation'))])]
  ///        ));
  ///}
  /// ```
  final Widget widget;

  /// Specifies the axis value for positioning annotation.
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///            annotations: <GaugeAnnotation>[
  ///            GaugeAnnotation(widget: Text('Annotation'), axisValue: 20)])]
  ///        ));
  ///}
  /// ```
  final double axisValue;

  /// Specifies the horizontal alignment for positioning the annotation widget.
  ///
  /// GaugeAlignment.Center aligns the annotation widget to center
  /// GaugeAlignment.near aligns the annotation widget to near
  /// GaugeAlignment.far aligns the annotation widget to far
  ///
  /// Also refer [GaugeAlignment]
  ///
  /// Defaults to GaugeAlignment.Center
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///            annotations: <GaugeAnnotation>[
  ///            GaugeAnnotation(widget: Text('Annotation'), horizontalAlignment: GaugeAlignment.near)])]
  ///        ));
  ///}
  /// ```
  final GaugeAlignment horizontalAlignment;

  /// Specifies the horizontal alignment for positioning the annotation widget.
  ///
  /// GaugeAlignment.Center aligns the annotation widget to center
  /// GaugeAlignment.near aligns the annotation widget to near
  /// GaugeAlignment.far aligns the annotation widget to far
  ///
  /// Also refer [GaugeAlignment]
  ///
  /// Defaults to GaugeAlignment.Center
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///            annotations: <GaugeAnnotation>[
  ///            GaugeAnnotation(widget: Text('Annotation'), verticalAlignment: GaugeAlignment.far)])]
  ///        ));
  ///}
  /// ```
  final GaugeAlignment verticalAlignment;

  /// Specifies the position of annotation either in axis value or radius factor.
  ///
  /// Defaults to 0
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///            annotations: <GaugeAnnotation>[
  ///            GaugeAnnotation(widget: Text('Annotation'), positionFactor: 0.5)])]
  ///        ));
  ///}
  ///```
  final double positionFactor;

  /// Specifies the angle for positioning the annotation
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///            annotations: <GaugeAnnotation>[
  ///            GaugeAnnotation(widget: Text('Annotation'), angle: 190)])]
  ///        ));
  ///}
  /// ```
  final double angle;

  /// Specifies the offset of positioning the annotation
  Offset _annotationPosition;

  /// Specifies the actual angle
  double _angle;

  /// Specifies the radian value of annotation
  double _radian;

  /// Specifies the axis bound to annotation
  RadialAxis _axis;

  /// Specifies the size of annotation widget
  Size _annotationSize;

  /// Specifies the opacity
  double _opacity;

  /// Specifies the left value for positioning the annotation
  double _left;

  /// Specifies the top value for positioning the annotation
  double _top;

  bool _isOldAnnotation;

  /// Calculates the offset for positioning the annotation
  void _calculatePosition() {
    final double _value = positionFactor != null ? positionFactor : 0;
    final double _offset = _value * (_axis._radius);
    _angle = _calculateActualAngle();
    _radian = _degreeToRadian(_angle);
    final double _x = (_axis._axisSize.width / 2) +
        (_offset - (_axis._actualAxisWidth / 2)) * math.cos(_radian) -
        _axis._centerX;
    final double _y = (_axis._axisSize.height / 2) +
        (_offset - (_axis._actualAxisWidth / 2)) * math.sin(_radian) -
        _axis._centerY;
    _annotationPosition = Offset(_x, _y);
  }

  /// Calculates the actual angle value
  double _calculateActualAngle() {
    double _actualValue = 0;
    if (angle != null) {
      _actualValue = angle;
    } else if (axisValue != null) {
      _actualValue = (_axis.valueToFactor(axisValue) * _axis._sweepAngle) +
          _axis.startAngle;
    }

    return _actualValue;
  }
}
