import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

enum IntervalType { work, rest }

abstract class _PomodoroStore with Store {
  @observable
  bool started = false;

  @observable
  int minutes = 2;

  @observable
  int seconds = 0;

  @observable
  int workTime = 0;

  @observable
  int restTime = 0;

  @observable
  IntervalType intervalType = IntervalType.work;

  Timer? timer;

  @action
  void start() {
    started = true;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minutes == 0 && seconds == 0) {
        _switchIntervalType();
      } else if (seconds == 0) {
        seconds = 59;
        minutes--;
      } else {
        seconds--;
      }
    });
  }

  @action
  void stop() {
    started = false;
    timer?.cancel();
  }

  @action
  void restart() {
    started = false;
    minutes = isWorking() ? workTime : restTime;
    seconds = 0;
  }

  @action
  void incrementWorkTime() {
    workTime++;

    if (isWorking()) {
      restart();
    }
  }

  @action
  void decrementWorkTime() {
    workTime--;
    if (isWorking()) {
      restart();
    }
  }

  @action
  void incrementRestTime() {
    restTime++;
    if (isResting()) {
      restart();
    }
  }

  @action
  void decrementRestTime() {
    restTime--;
    if (isResting()) {
      restart();
    }
  }

  bool isWorking() {
    return intervalType == IntervalType.work;
  }

  bool isResting() {
    return intervalType == IntervalType.rest;
  }

  void _switchIntervalType() {
    if (isWorking()) {
      intervalType = IntervalType.work;
      minutes = workTime;
    } else {
      intervalType = IntervalType.rest;
      minutes = restTime;
    }

    seconds = 0;
  }
}

class PomodoroStore = _PomodoroStore with _$PomodoroStore;
