extension Kotlin<T> on T {
  T also(void Function(T it) function) {
    function(this);
    return this;
  }

  R let<R>(R Function(T it) function) {
    return function(this);
  }
}