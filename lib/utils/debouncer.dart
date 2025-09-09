import 'dart:async';

class Debouncer {
  Debouncer({required this.duration});

  final Duration duration;
  Timer? _timer;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }
  
  void cancel() {
    _timer?.cancel();
  }
}