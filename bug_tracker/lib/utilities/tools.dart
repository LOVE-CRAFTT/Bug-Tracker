double normalize0to1(double value) {
  value = value.clamp(0, 100);
  return value /= 100;
}
