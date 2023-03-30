import 'dart:math';

List<T> shuffle<T>(List<T> l) {
  List<T> l2 = List.from(l);
  l2.shuffle(Random());
  return l2;
}
