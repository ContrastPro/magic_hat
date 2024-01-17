import 'dart:math';

int randomNumber(int max) {
  final DateTime now = DateTime.now();
  final Random random = Random(now.millisecondsSinceEpoch);

  return random.nextInt(max);
}