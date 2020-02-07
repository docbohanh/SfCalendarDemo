part of gauges;

/// GaugeAlignment.near aligns the gauge to near
/// whereas GaugeAlignment.center aligns the gauge to center
/// and the GaugeAlignment.ar aligns the gauge to far
enum GaugeAlignment { near, center, far }

/// ElementPosition.inside places the axis elements inside the axis
/// whereas ElementPosition.outside places the axis elements outside the axis
enum ElementsPosition { inside, outside }

/// CornerStyle.bothFlat does not render the rounded corner on both side
/// CornerStyle.bothCurve renders the rounded corner on both side
/// CornerStyle.startCurve renders the rounded corner on start side
/// CornerStyle.endCurce renders the rounded corner on end side
enum CornerStyle { bothFlat, bothCurve, startCurve, endCurve }

/// MarkerText.invertedTriangle points the value with inverted triangle
/// MarkerText.triangle points the value with triangle
/// MarkerText.circle points the value with circle
/// MarkerText.rectangle points the value with rectangle
/// MarkerText.diamond points the value with diamond
/// MarkerText.image points the value with image
/// MarkerText.slider points the value with slider
enum MarkerType {
  invertedTriangle,
  triangle,
  circle,
  rectangle,
  diamond,
  image,
  text
}

/// AnimationType.bounceOut animates the pointer with Curves.bounceOut
/// AnimationType.ease animates the pointer with Curves.ease
/// AnimationType.easeInCirc animates the pointer with Curves.easeInCirc
/// AnimationType.easeOutBack animates the pointer with Curves.easeOutBack
/// AnimationType.elasticOut animates the pointer with Curves.elasticOut
/// AnimationType.linear animates the pointer with Curves.linear
/// AnimationType.slowMiddle animates the pointers with Curves.slowMiddle
enum AnimationType {
  bounceOut,
  ease,
  easeInCirc,
  easeOutBack,
  elasticOut,
  linear,
  slowMiddle
}

/// GaugeSizeUnit.factor specifies the size in factor 0 to 1
/// GaugeSizeUnit.logicalPixel specifies the size in  logical pixel
enum GaugeSizeUnit { factor, logicalPixel }
