import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchPage extends StatefulWidget {

  final int userSeconds;
  final int userMinutes;

  const StopWatchPage({Key? key, required this.userSeconds, required this.userMinutes}) : super(key: key);

  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  static Duration countdownDuration = const Duration();
  Duration duration = const Duration();
  Timer? timer;

  bool isCountdown = true;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    if (isCountdown) {
      countdownDuration = Duration(minutes: widget.userMinutes, seconds: widget.userSeconds);
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if(seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    if(resets) {
      reset();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {

    final isRunning = timer == null ? false : timer!.isActive;
    int uSeconds = widget.userSeconds + (widget.userMinutes * 60);
    final isCompleted = duration.inSeconds == uSeconds || duration.inSeconds == 0;

    // 9 --> 09     11 --> 11
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTimeCard(time: hours, header: 'HOURS'),
                  const SizedBox(width: 8,),
                  buildTimeCard(time: minutes, header: 'MINUTES'),
                  const SizedBox(width: 8,),
                  buildTimeCard(time: seconds, header: 'SECONDS'),
                ]
              ),
              const SizedBox(
                height: 20,
              ),
              !isRunning && !isCompleted ?
              Text('Paused at: $minutes : $seconds'.toString(), style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35
              ),) : const SizedBox(
                height: 40,
              ),
              const SizedBox(
                height: 20,
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
                        stopTimer(resets: false);
                      } else {
                        startTimer(resets: false);
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
                  startTimer(resets: true);
                },
              )
            ]
          ),
        ),
      ),
    );
  }

  buildTimeCard({required String time, required String header}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(time, style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 60
          ),),
        ),
        const SizedBox(height: 20,),
        Text(header, style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18
        ),)
      ],
    );
}
