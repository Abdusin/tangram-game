class Tupple<T, U> {
  final T first;
  final U second;
  const Tupple(this.first, this.second);
  @override
  String toString() => '$first, $second';
}

class Tupple3<T, U, K> {
  final T first;
  final U second;
  final K third;
  const Tupple3(this.first, this.second, this.third);
  @override
  String toString() => '$first, $second, $third';
}
