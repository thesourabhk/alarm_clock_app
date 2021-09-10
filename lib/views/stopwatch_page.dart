import 'package:clock_app/constants/theme_data.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class StopwatchPager extends StatefulWidget {
  // const StopwatchPager({ Key? key }) : super(key: key);

  @override
  _StopwatchPagerState createState() => _StopwatchPagerState();
}

class _StopwatchPagerState extends State<StopwatchPager> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'StopWatch',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24),
          ),
          SizedBox(height: 16),
          StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snapshot) {
                final value = snapshot.data;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: _isHours);
                return Text(displayTime,
                    style: TextStyle(
                        color: CustomColors.dividerColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold));
              }),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    color: Colors.green[300],
                    label: "Start",
                    onPress: () {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                    },
                  ),
                  SizedBox(width: 10.0),
                  CustomButton(
                    color: Colors.red[200],
                    label: "Stop",
                    onPress: () {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    color: Color(0xFFF15C2A),
                    label: "Lap",
                    onPress: () {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                    },
                  ),
                  SizedBox(width: 10.0),
                  CustomButton(
                    color: Colors.black,
                    label: "Reset",
                    onPress: () {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                    },
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 150,
            margin: const EdgeInsets.all(8),
            child: StreamBuilder<List<StopWatchRecord>>(
              stream: _stopWatchTimer.records,
              initialData: _stopWatchTimer.records.value,
              // ignore: missing_return
              builder: (context, snapshot) {
                final value = snapshot.data;
                if (value.isEmpty) {
                  return Container();
                }
                // ignore: dead_code
                Future.delayed(const Duration(milliseconds: 100), () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  );
                });

                return ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    final data = value[index];
                    return Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${index + 1} - ${data.displayTime}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700))),
                        Divider(height: 1.0),
                      ],
                    );
                  },
                  itemCount: value.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final Function onPress;
  final String label;

  CustomButton({this.color, this.onPress, this.label});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      shape: const StadiumBorder(),
      onPressed: onPress,
      child: Text(label, style: TextStyle(color: Colors.white12)),
    );
  }
}
