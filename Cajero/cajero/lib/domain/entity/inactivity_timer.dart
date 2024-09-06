import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InactivityTimer {
  final Duration duration;
  Timer? _timer;
  final VoidCallback onInactivity;

  InactivityTimer({
    required this.duration,
    required this.onInactivity,
  }) {
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(duration, onInactivity);
  }

  void reset() {
    _startTimer();
  }

  void dispose() {
    _timer?.cancel();
  }
}

InactivityTimer useInactivityTimer(
    Duration duration, VoidCallback onInactivity) {
  final timer = useMemoized(
      () => InactivityTimer(duration: duration, onInactivity: onInactivity));
  useEffect(() {
    return timer.dispose;
  }, [timer]);
  return timer;
}
