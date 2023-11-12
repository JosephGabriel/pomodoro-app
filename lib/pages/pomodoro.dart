import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/time_input.dart';
import 'package:pomodoro/components/timer.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Pomodoro'),
          const Expanded(child: Timer()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimeInput(
                    time: store.workTime,
                    title: 'Trabalho',
                    increment: store.started && store.isWorking()
                        ? null
                        : store.incrementWorkTime,
                    decrement: store.started && store.isWorking()
                        ? null
                        : store.decrementWorkTime,
                  ),
                  TimeInput(
                    time: store.restTime,
                    title: 'Descanso',
                    increment: store.started && store.isResting()
                        ? null
                        : store.incrementRestTime,
                    decrement: store.started && store.isResting()
                        ? null
                        : store.decrementRestTime,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
