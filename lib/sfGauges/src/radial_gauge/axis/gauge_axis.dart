part of gauges;

/// Customizes the axis in gauge.
abstract class GaugeAxis {
  GaugeAxis(
      {this.ranges,
      this.pointers,
      this.annotations,
      this.minimum = 0,
      this.maximum = 100,
      this.interval,
      this.minorTicksPerInterval = 1,
      this.showLabels = true,
      this.showAxisLine = true,
      this.showTicks = true,
      this.tickOffset = 0,
      this.labelOffset = 20,
      this.isInversed = false,
      this.maximumLabels = 3,
      this.useRangeColorForAxis = false,
      this.labelFormat,
      this.numberFormat,
      this.ticksPosition = ElementsPosition.inside,
      this.labelsPosition = ElementsPosition.inside,
      this.offsetUnit = GaugeSizeUnit.logicalPixel,
      GaugeTextStyle axisLabelStyle,
      AxisLineStyle axisLineStyle,
      MajorTickStyle majorTickStyle,
      MajorTickStyle minorTickStyle})
      : axisLabelStyle = axisLabelStyle ??
            GaugeTextStyle(
                fontSize: 12.0,
                fontFamily: 'Segoe UI',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal),
        axisLineStyle = axisLineStyle ??
            AxisLineStyle(
              thickness: 10,
            ),
        majorTickStyle = majorTickStyle ?? MajorTickStyle(length: 10),
        minorTickStyle = minorTickStyle ?? MinorTickStyle(length: 5);

  /// Specifies the ranges collection in gauge.
  ///
  /// Also refer [GaugeRange]
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
  ///          endValue: 100)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final List<GaugeRange> ranges;

  /// Specifies the pointers collection in gauge.
  ///
  /// Also refer [GaugePointer]
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final List<GaugePointer> pointers;

  /// Specifies the annotations collection in gauge.
  ///
  /// Also refer [GaugeAnnotation]
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
  final List<GaugeAnnotation> annotations;

  /// The minimum value of the axis. The axis starts from this value.
  ///
  /// Defaults to 0
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          minimum : 30,
  ///            )]
  ///        ));
  ///}
  /// ```
  final double minimum;

  /// The maximum value of the axis. The axis ends at this value.
  ///
  /// Defaults to 100
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          maximum: 200,
  ///            )]
  ///        ));
  ///}
  /// ```
  final double maximum;

  ///Axis interval value. Using this, the axis labels can be displayed after certain interval value.
  ///
  /// Defaults to null
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          interval: 20,
  ///            )]
  ///        ));
  ///}
  /// ```
  final double interval;

  /// Interval of the minor ticks.
  ///
  /// Defaults to 1
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          minorTicksPerInterval: 3,
  ///            )]
  ///        ));
  ///}
  /// ```
  final double minorTicksPerInterval;

  /// Shows or hides the axis labels.
  ///
  /// Defaults to true
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          showLabels: false,
  ///            )]
  ///        ));
  ///}
  /// ```
  final bool showLabels;

  /// Shows or hides the axis line.
  ///
  /// Defaults to true
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           showAxisLine: false,
  ///            )]
  ///        ));
  ///}
  /// ```
  final bool showAxisLine;

  /// Shows or hides the axis tick lines.
  ///
  /// Defaults to true
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           showTicks: false,
  ///            )]
  ///        ));
  ///}
  /// ```
  final bool showTicks;

  /// Adjusts the axis ticks distance from axis lines.
  /// You can specify value either in logical pixel or radius factor using the offsetUnit property.
  ///
  /// Defaults to 0
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           tickOffset: 20
  ///            )]
  ///        ));
  ///}
  /// ```
  final double tickOffset;

  /// Adjusts the axis label distance from tick end.
  /// You can specify value either in logical pixel or radius factor using the offsetUnit property.
  ///
  /// Defaults to 15
  ///```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           labelOffset: 30
  ///            )]
  ///        ));
  ///}
  ///```
  final double labelOffset;

  ///Inverts the axis.
  /// Axis is rendered in clockwise by default, and
  /// it can be inverted to render the axis in counterclockwise direction.
  ///
  /// Defaults to false
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///            isInversed: true,
  ///            )]
  ///        ));
  ///}
  /// ```
  final bool isInversed;

  /// The maximum number of labels to be displayed in an axis in 100 logical pixels.
  ///
  /// Defaults to 3
  ///```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           maximumLabels: 5
  ///            )]
  ///        ));
  ///}
  ///```
  final int maximumLabels;

  /// Specifies whether to use the range color for axis elements such as labels and ticks.
  ///
  /// Defaults to false
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           useRangeColorForAxis : true,
  ///           ranges: <GaugeRange>[GaugeRange(
  ///           startValue: 50,
  ///           endValue: 100)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final bool useRangeColorForAxis;

  ///Formats the axis labels. The labels can be customized by adding the desired text as prefix or suffix.
  ///
  /// Defaults to null
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           labelFormat: '{value}M'
  ///            )]
  ///        ));
  ///}
  /// ```
  final String labelFormat;

  /// Formats the axis labels with globalized label formats.
  ///
  /// Defaults to null
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           numberFormat: NumberFormat.currencyCompact()
  ///            )]
  ///        ));
  ///}
  /// ```
  final NumberFormat numberFormat;

  /// Positions the tick lines. Tick lines can be placed either inside or outside the axis line.
  ///
  /// ElementsPosition.inside places the ticks inside the axis line
  /// ElementsPosition.outside places the ticks outside the axis line
  ///
  /// Also refer [ElementsPosition]
  ///
  /// Defaults to ElementsPosition.inside
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           ticksPosition: ElementsPosition.outside,
  ///            )]
  ///        ));
  ///}
  /// ```
  final ElementsPosition ticksPosition;

  ///Positions the axis label. Axis labels can be placed either inside or outside the axis line.
  ///
  /// ElementsPosition.inside places the labels inside the axis line
  /// ElementsPosition.outside places the labels outside the axis line
  ///
  /// Also refer [ElementsPosition]
  ///
  /// Defaults to ElementsPosition.inside
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           labelsPosition: ElementsPosition.outside,
  ///            )]
  ///        ));
  ///}
  /// ```
  final ElementsPosition labelsPosition;

  /// Customizes the axis label.
  ///
  /// Also refer [GaugeTextStyle]
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          axisLabelStyle: GaugeTextStyle(fontSize: 20,
  ///          fontStyle: FontStyle.italic),
  ///            )]
  ///        ));
  ///}
  /// ```
  final GaugeTextStyle axisLabelStyle;

  /// Customizes the axis line.
  ///
  /// Also refer [AxisLineStyle]
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           axisLineStyle: AxisLineStyle(color: Colors.red,
  ///           thickness: 20),
  ///            )]
  ///        ));
  ///}
  /// ```
  final AxisLineStyle axisLineStyle;

  /// Customizes the major tick line.
  ///
  /// Also refer [MajorTickStyle]
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///            majorTickStyle: MajorTickStyle(color: Colors.red,
  ///            thickness: 3,
  ///            length: 10),
  ///            )]
  ///        ));
  ///}
  /// ```
  final MajorTickStyle majorTickStyle;

  /// Customizes the minor tick line.
  ///
  /// Also refer [MinorTickStyle]
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///            minorTickStyle: MinorTickStyle(color: Colors.red,
  ///            thickness: 3,
  ///            length: 10),
  ///            )]
  ///        ));
  ///}
  /// ```
  final MinorTickStyle minorTickStyle;

  /// Calculates the offset position either in logical pixel or radius factor.
  ///
  /// Defaults to logical pixel.
  ///```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           labelOffset: 0.3, offsetUnit: GaugeSizeUnit.factor
  ///            )]
  ///        ));
  ///}
  ///```
  final GaugeSizeUnit offsetUnit;

  /// Calculates the visible labels based on axis interval and range.
  List<CircularAxisLabel> generateVisibleLabels();

  /// Converts the axis value to factor based on angle.
  double valueToFactor(double value);

  /// Converts the factor value to axis value.
  double factorToValue(double factor);

  /// Returns the axis range based on its minimum and maximum.
  num calculateRange();
}
