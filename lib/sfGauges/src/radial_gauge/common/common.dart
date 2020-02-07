part of gauges;

/// Customizes the text in gauge.
class GaugeTextStyle {
  /// Creates the gauge text style
  GaugeTextStyle(
      {this.color,
      this.fontFamily = 'Segoe UI',
      this.fontStyle = FontStyle.normal,
      this.fontWeight = FontWeight.normal,
      this.fontSize = 12});

  ///Specifies the text color
  Color color;

  /// Specifies the font family
  String fontFamily;

  /// Specifies the font style
  FontStyle fontStyle;

  /// Specifies the font weight
  FontWeight fontWeight;

  /// Specifies the font size
  double fontSize;
}

/// Customizes the gauge title.
///
/// ```dart
///Widget build(BuildContext context) {
///    return Container(
///        child: SfRadialGauge(
///            title: GaugeTitle(
///                    text: 'Gauge Title',
///                    textStyle: TextStyle(
///                                 color: Colors.red,
///                                 fontSize: 12,
///                                 fontStyle: FontStyle.normal,
///                                 fontWeight: FontWeight.w400,
///                                 fontFamily: 'Roboto'
///                               ))
///        ));
///}
/// ```
class GaugeTitle {
  /// Creates the gauge title
  GaugeTitle(
      {@required this.text,
      TextStyle textStyle,
      this.alignment = GaugeAlignment.center,
      this.borderColor,
      this.borderWidth = 0,
      this.backgroundColor})
      : textStyle = textStyle ??
            const TextStyle(
                fontSize: 15.0,
                fontFamily: 'Segoe UI',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal);

  /// Text to be displayed as gauge title.
  /// If the text of the gauge exceeds, then text will be wrapped into multiple rows.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///            title: GaugeTitle(
  ///                    text: 'Gauge Title'
  ///                   )
  ///        ));
  ///}
  ///```
  final String text;

  ///Customizes the appearance of the gauge title.
  ///
  /// '''dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///            title: GaugeTitle(
  ///                    text: 'Gauge Title',
  ///                    textStyle: TextStyle(
  ///                                 color: Colors.red,
  ///                                 fontSize: 12,
  ///                                 fontStyle: FontStyle.normal,
  ///                                 fontWeight: FontWeight.w400,
  ///                                 fontFamily: 'Roboto'
  ///                               ))
  ///        ));
  ///}
  ///```
  final TextStyle textStyle;

  ///Customizes the background color of gauge title.
  ///
  /// Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///            title: GaugeTitle(
  ///                    text: 'Gauge Title',
  ///                    backgroundColor: Colors.red
  ///                   )
  ///        ));
  ///}
  ///```
  final Color backgroundColor;

  /// Customizes the border color of the gauge title.
  ///
  /// Defaults to null
  ///```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///            title: GaugeTitle(
  ///                    text: 'Gauge Title',
  ///                    borderColor: Colors.red,
  ///                      borderWidth: 1
  ///                   )
  ///        ));
  ///}
  ///```
  final Color borderColor;

  /// Specifies the border width of the gauge title.
  ///
  /// Defaults to 0
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///            title: GaugeTitle(
  ///                    text: 'Gauge Title',
  ///                    borderColor: Colors.red,
  ///                    borderWidth: 1
  ///                   )
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Aligns the gauge title.
  ///The alignment is applicable when the width of the gauge title is less than the width of the gauge.
  ///
  /// GaugeAlignment.near places the title at the beginning of gauge whereas the GaugeAlignment.Center
  /// moves the gauge title to the center of gauge and the GaugeAlignment.far places the
  /// gauge title at the end of the gauge
  ///
  /// Defaults to GaugeAlignment.center
  ///
  /// Also refer [GaugeAlignment]
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///            title: GaugeTitle(
  ///                    text: 'Gauge Title',
  ///                    alignment: GaugeAlignment.far
  ///                   )
  ///        ));
  ///}
  ///```
  final GaugeAlignment alignment;
}

/// Represents the tick style.
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
class MajorTickStyle {
  /// Creates the tick style for customizing ticks
  MajorTickStyle(
      {this.length = 7,
      this.thickness = 1.5,
      this.lengthUnit = GaugeSizeUnit.logicalPixel,
      this.color,
      this.dashArray})
      : assert(length >= 0),
        assert(thickness >= 0);

  /// Specifies the length of tick either in logical pixel or radial factor using the SizeUnit property.
  ///
  /// Defaults to 7
  /// ``` dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (majorTickStyle:
  ///              MajorTickStyle(length: 10),)]
  ///        ));
  ///}
  /// ```
  final double length;

  /// Calculates the tick length size either in logical pixel or radius factor.
  ///
  /// Also refer [GaugeSizeUnit]
  ///
  /// Defaults to SizeUnit.logicalPixel
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (majorTickStyle:
  ///              MajorTickStyle(lengthUnit: GaugeSizeUnit.factor, length:0.05),)]
  ///        ));
  ///}
  /// ```
  final GaugeSizeUnit lengthUnit;

  /// Specifies the thickness of tick.
  ///
  /// Defaults to 1.5
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (majorTickStyle:
  ///              MajorTickStyle(thickness: 2),)]
  ///        ));
  ///}
  /// ```
  final double thickness;

  /// Specifies the color of tick.
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (majorTickStyle:
  ///              MajorTickStyle(color: Colors.lightBlue),)]
  ///        ));
  ///}
  /// ```
  final Color color;

  /// Specifies the dash array to draw the dashed line.
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (majorTickStyle:
  ///              MajorTickStyle(dashArray: <double>[2.5, 2.5]),)]
  ///        ));
  ///}
  /// ```
  final List<double> dashArray;
}

/// Represents the minor tick style.
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
class MinorTickStyle extends MajorTickStyle {
  /// Creates the instance for customizing the minor ticks
  MinorTickStyle(
      {double length = 5,
      GaugeSizeUnit lengthUnit,
      Color color,
      double thickness = 1.5,
      List<double> dashArray})
      : assert(length >= 0),
        assert(thickness >= 0),
        super(
          length: length,
          lengthUnit: lengthUnit ?? GaugeSizeUnit.logicalPixel,
          thickness: thickness,
          dashArray: dashArray,
          color: color,
        );
}

/// Represents the axis line style.
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
class AxisLineStyle {
  /// Creates the axis line style for gauge axis
  AxisLineStyle(
      {this.thickness = 10,
      this.thicknessUnit = GaugeSizeUnit.logicalPixel,
      this.color,
      this.gradient,
      this.cornerStyle = CornerStyle.bothFlat,
      this.dashArray})
      : assert(thickness >= 0),
        assert((gradient != null && gradient is SweepGradient) ||
            gradient == null);

  /// Specifies the thickness of axis line either in logical pixel or radial factor using the thicknessUnit property.
  ///
  /// Also refer [GaugeSizeUnit]
  ///
  /// Defaults to SizeUnit.logicalPixel
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (axisLineStyle:
  ///           AxisLineStyle(thickness: 0.2, thicknessUnit: GaugeSizeUnit.factor),)]
  ///        ));
  ///}
  /// ```
  final GaugeSizeUnit thicknessUnit;

  /// Specifies the thickness of axis line.
  ///
  /// Defaults to 10
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (axisLineStyle:
  ///           AxisLineStyle(thickness: 20),)]
  ///        ));
  ///}
  /// ```
  final double thickness;

  /// Specifies the color of axis line.
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (axisLineStyle:
  ///           AxisLineStyle(color: Colors.grey),)]
  ///        ));
  ///}
  /// ```
  final Color color;

  /// Specifies the corner style for axis line.
  ///
  /// CornerStyle.bothFlat renders the flat line at the both the corners of axis line
  /// CornerStyle.bothCurve renders the rounded corner at the both the end of axis line
  /// CornerStyle.startCurve renders the rounded corner at the start of axis line
  /// CornerStyle.endCurve renders the rounded corner at the end of axis line
  ///
  /// Also refer [CornerStyle]
  ///
  /// Defaults to CornerStyle.bothFlat
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (axisLineStyle:
  ///           AxisLineStyle(cornerStyle: CornerStyle.bothCurve),)]
  ///        ));
  ///}
  /// ```
  final CornerStyle cornerStyle;

  /// Specifies the dash array for axis line to draw the dashed line.
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (axisLineStyle:
  ///           AxisLineStyle(dashArray: <double>[5, 5],)]
  ///        ));
  ///}
  /// ```
  final List<double> dashArray;

  /// Specifies the gradient color for the axis line
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///           (axisLineStyle:
  ///           AxisLineStyle(dashArray: <double>[5, 5],  gradient: SweepGradient(
  ///                   colors: const <Color>[Colors.deepPurple,Colors.red,
  ///                     Color(0xFFFFDD00), Color(0xFFFFDD00), Color(0xFF30B32D), ],
  ///                   stops: const <double>[0,0.03, 0.5833333, 0.73, 1],
  ///                 ),)]
  ///        ));
  ///}
  /// ```
  final Gradient gradient;
}

/// Holds the axis label information.
class CircularAxisLabel {
  /// Creates the axis label
  CircularAxisLabel(
      this.labelStyle, this.text, this.index, this._needsRotateLabel);

  /// It specifies the text style of label
  GaugeTextStyle labelStyle;

  /// It holds size of label
  Size labelSize;

  /// It holds text of label to be print
  String text;

  /// Specifies the axis index position
  num index;

  ///Specifies the value of the labels
  num value;

  /// Holds the label position
  Offset position;

  /// Holds the corresponding angle for the label
  double angle;

  /// Specifies whether to rotate the corresponding labels
  final bool _needsRotateLabel;
}

/// Represents the arc data
class _ArcData {
  /// Represents the start angle
  double _startAngle;

  /// Represents the end angle
  double _endAngle;

  /// Represents the arc rect
  Rect _arcRect;
}

/// Specifies the offset value of tick
class _TickOffset {
  /// Holds the start point
  Offset startPoint;

  /// Holds the end point
  Offset endPoint;

  /// Holds the tick value
  double value;
}

/// Hold the onLabelCreated event arguments
class AxisLabelCreatedArgs {
  /// Holds the label text
  String text;

  /// Specifies the label style
  GaugeTextStyle labelStyle;

  /// Specifies whether to rotate the label
  bool canRotate;
}

/// Holds the pointer value changing event arguments
class ValueChangingArgs {
  /// Specifies the value which is tapped
  double value;

  /// Specifies whether to cancel the pointer dragging event
  bool cancel;
}

/// Represents the tail style
///
/// ```dart
///Widget build(BuildContext context) {
///    return Container(
///        child: SfRadialGauge(
///          axes:<RadialAxis>[RadialAxis
///          ( pointers: <GaugePointer>[
///             NeedlePointer( value: 20, tailStyle:
///                 TailStyle(width: 5, lengthFactor: 0.2)
///           )])]
///        ));
///}
/// ```
class TailStyle {
  /// Creates the tail style
  TailStyle(
      {this.color,
      this.width = 0,
      this.length = 0,
      this.borderWidth = 0,
      this.gradient,
      this.lengthUnit = GaugeSizeUnit.factor,
      this.borderColor})
      : assert(width >= 0),
        assert(length >= 0),
        assert(borderWidth >= 0);

  /// Specifies the color of the tail.
  ///
  /// Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( tailStyle:
  ///                 TailStyle(color: Colors.lightBlue, width: 10, length: 0.1)
  ///           )])]
  ///        ));
  ///}
  ///```
  final Color color;

  /// Specifies the width of the tail.
  ///
  /// Defaults to 0
  /// ``` dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( tailStyle:
  ///                 TailStyle(width: 10, length: 0.1)
  ///           )])]
  ///        ));
  ///}
  //// ```
  final double width;

  /// Specifies the length of the tail either in logical pixel or radius factor.
  ///
  /// Defaults to 0
  /// ``` dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( tailStyle:
  ///                 TailStyle(width: 10,length: 0.2)
  ///           )])]
  ///        ));
  ///}
  /// ```
  final double length;

  /// Calculates the length of tail either in logical pixel or radius factor.
  ///
  /// Also refer [GaugeSizeUnit]
  ///
  /// Defaults to SizeUnit.factor
  /// ``` dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( tailStyle:
  ///                 TailStyle(length: 30, lengthUnit: GaugeSizeUnit.logicalPixel, width: 10)
  ///           )])]
  ///        ));
  ///}
  /// ```
  final GaugeSizeUnit lengthUnit;

  /// Specifies the border width of tail.
  ///
  /// Defaults to 0
  /// ``` dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( tailStyle:
  ///                 TailStyle(borderWidth: 2,width: 10,length: 0.2, borderColor: Colors.red)
  ///           )])]
  ///        ));
  ///}
  /// ```
  final double borderWidth;

  /// Specifies the border color of tail.
  ///
  /// Defaults to null
  /// ``` dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( tailStyle:
  ///                 TailStyle(borderWidth: 2,width: 10,length: 0.2, borderColor: Colors.red)
  ///           )])]
  ///        ));
  ///}
  /// ```
  final Color borderColor;

  /// Specifies the gradient color of tail.
  ///
  /// Defaults to null
  /// ``` dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( tailStyle:
  ///                 TailStyle(borderWidth: 2,width: 10,length: 0.2,
  ///                    gradient: LinearGradient(
  ///                  colors: const <Color>[Color.fromRGBO(28, 114, 189, 1),Color.fromRGBO(28, 114, 189, 1),
  ///                    Color.fromRGBO(23, 173, 234, 1),Color.fromRGBO(23, 173, 234, 1)],
  ///                  stops: const <double>[0,0.5,0.5,1],
  ///
  ///             )
  ///                 )
  ///           )])]
  ///        ));
  ///}
  /// ```
  final LinearGradient gradient;
}

/// Represents the knob style of needle pointer.
///
/// ```dart
///Widget build(BuildContext context) {
///    return Container(
///        child: SfRadialGauge(
///          axes:<RadialAxis>[RadialAxis
///          ( pointers: <GaugePointer>[
///             NeedlePointer( value: 30,
///              knobStyle: KnobStyle(knobRadius: 0.1),
///           )])]
///        ));
///}
/// ```
class KnobStyle {
  /// Creates the knob style
  KnobStyle(
      {this.knobRadius = 0.08,
      this.borderWidth = 0,
      this.sizeUnit = GaugeSizeUnit.factor,
      this.borderColor,
      this.color})
      : assert(knobRadius >= 0),
        assert(borderWidth >= 0);

  /// Specifies the knob radius value either in logical pixel or radius factor.
  ///
  /// Defaults to 0.8
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer(knobStyle: KnobStyle(knobRadius: 0.2),
  ///           )])]
  ///        ));
  ///}
  /// ```
  final double knobRadius;

  /// Calculates the knob radius size and border width either in logical pixel or radius factor.
  ///
  /// Also refer [GaugeSizeUnit]
  ///
  /// Defaults to SizeUnit.factor
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer(
  ///                 knobStyle: KnobStyle(knobRadius: 10, sizeUnit: GaugeSizeUnit.logicalPixel),
  ///           )])]
  ///        ));
  ///}
  /// ```
  final GaugeSizeUnit sizeUnit;

  /// Specifies the knob border width in logical pixel.
  ///
  /// Defaults to 0
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer(
  ///                  knobStyle: KnobStyle(borderWidth: 2, borderColor : Colors.red),
  ///           )])]
  ///        ));
  ///}
  /// ```
  final double borderWidth;

  /// Specifies the knob color.
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer(
  ///              knobStyle: KnobStyle(color: Colors.red),
  ///           )])]
  ///        ));
  ///}
  /// ```
  final Color color;

  /// Specifies the knob border color.
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <Pointer>[
  ///             NeedlePointer(
  ///              knobStyle: KnobStyle(borderColor: Colors.red, borderWidth: 2),
  ///           )])]
  ///        ));
  ///}
  /// ```
  final Color borderColor;
}
