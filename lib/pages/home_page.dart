import 'package:flutter/material.dart';
import 'package:flutter_timer/pages/stop_watch_page.dart';
import 'package:flutter_timer/pages/timer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _secondETC = TextEditingController(text: "0");
  final _minutesETC = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    width: 150,
                    child: TextField(
                      onChanged: (_) => setState(() {}),
                      controller: _minutesETC,
                      decoration: InputDecoration(
                          labelStyle: const TextStyle(
                              color: Colors.white
                          ),
                          labelText: "Enter Minutes",
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1)
                          ),
                        errorText: _minutesErrorText
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 150,
                      child: TextField(
                        controller: _secondETC,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: Colors.white
                            ),
                            labelText: "Enter Seconds",
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 1)
                            ),
                          errorText: _secondsErrorText,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  child: const Text('Enter', style: TextStyle(
                    fontSize: 18
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  ),
                  onPressed: () {
                    if (validate()) {
                      int _secondsTime = int.parse(_secondETC.text);
                      int _minutesTime = int.parse(_minutesETC.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StopWatchPage(
                                userSeconds: _secondsTime,
                                userMinutes: _minutesTime),
                          ));
                    }
                  })
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validate() {
    if(_secondETC.text.isEmpty || _minutesETC.text.isEmpty) {
      return false;

    } else {
      return true;
    }
  }

  String? get _secondsErrorText {
    final text = _secondETC.value.text;
    if (text.isEmpty) {
      return 'Seconds can\'t be empty';
    }
    return null;
  }

  String? get _minutesErrorText {
    final text = _minutesETC.value.text;
    if (text.isEmpty) {
      return 'Minutes can\'t be empty';
    }
    return null;
  }
}
