import 'package:alarm_clock_app/constrants/theme_data.dart';
import 'package:flutter/material.dart';

class StopwatchPager extends StatefulWidget {
  // const StopwatchPager({ Key? key }) : super(key: key);

  @override
  _StopwatchPagerState createState() => _StopwatchPagerState();
}

class _StopwatchPagerState extends State<StopwatchPager> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        ],
      ),
    );
  }
}
