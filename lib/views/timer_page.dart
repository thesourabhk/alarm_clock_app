import 'package:clock_app/constants/theme_data.dart';
import 'package:flutter/material.dart';

class TimerPager extends StatefulWidget {
  // const TimerPager({ Key key }) : super(key: key);

  @override
  _TimerPagerState createState() => _TimerPagerState();
}

class _TimerPagerState extends State<TimerPager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Timer',
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
