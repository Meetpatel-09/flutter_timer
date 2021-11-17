import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {

  final int userTime;
  const TimerPage({Key? key, required this.userTime}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {

  int maxSeconds = 0;
  // A() => maxSeconds = widget.userTime;

  int seconds = 0;
  // B() => seconds = maxSeconds;

  Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void startTimer({bool reset = true}) {

    if(reset) {
      resetTimer();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // maxSeconds = widget.userTime;
      // seconds = maxSeconds;
      if(seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if(reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {

    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isRunning || !isCompleted ?
              Text('$seconds'.toString(), style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 80
              ),) : Text(widget.userTime.toString(), style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 80
              ),),
              const SizedBox(
                height: 40,
              ),
              !isRunning && !isCompleted ?
              Text('Paused at: $seconds'.toString(), style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35
              ),) : const SizedBox(
                height: 40,
              ),
              const SizedBox(
                height: 40,
              ),
              isRunning || !isCompleted ?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    ),
                    child: isRunning ? const Text('Pause', style: TextStyle(
                      fontSize: 20,
                    ),
                    ) :
                    const Text('Resume', style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                    onPressed: () {
                      if(isRunning) {
                        stopTimer(reset: false);
                      } else {
                        startTimer(reset: false);
                      }
                    },
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    ),
                    child: const Text('Cancel', style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                    onPressed: () {
                      stopTimer();
                    },
                  ),
                ],
              )
              :ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                ),
                child: const Text('Start Timer', style: TextStyle(
                  fontSize: 20,
                ),
                ),
                onPressed: () {
                  maxSeconds = widget.userTime;
                  seconds = maxSeconds;
                  startTimer(reset: true);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
