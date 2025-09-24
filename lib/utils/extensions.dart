import 'dart:ui';

extension OpacityParsing on Color {
  // .withOpacity() has been depreciated
  // The propesed replacement .withValues(alpha: ) has a max of 255
  // Hence this extension method retains the scale of 0 to 1
  Color addOpacity(double opacity) {
    if (opacity >= 0.0 && opacity <= 1.0) {
      return withAlpha((255.0 * opacity).round());
    }
    return this;
  }
}
