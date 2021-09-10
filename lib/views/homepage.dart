import 'package:clock_app/constants/theme_data.dart';
import 'package:clock_app/data.dart';
import 'package:clock_app/enums.dart';
import 'package:clock_app/models/menu_info.dart';
import 'package:clock_app/views/alarm_page.dart';
import 'package:clock_app/views/clock_page.dart';
import 'package:clock_app/views/stopwatch_page.dart';
import 'package:clock_app/views/timer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Consumer<MenuInfo>(
              // ignore: missing_return
              builder: (BuildContext context, MenuInfo value, Widget child) {
                if (value.menuType == MenuType.clock) {
                  return ClockPage();
                } else if (value.menuType == MenuType.alarm) {
                  return AlarmPage();
                } else if (value.menuType == MenuType.stopwatch) {
                  return StopwatchPager();
                } else if (value.menuType == MenuType.timer) {
                  return TimerPager();
                }
              },
            ),
          ),
          Divider(
            color: CustomColors.dividerColor,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(28), topLeft: Radius.circular(28))),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          color: currentMenuInfo.menuType == value.menuType
              ? CustomColors.menuBackgroundColor
              : Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Row(
            children: <Widget>[
              Column(
                children: [
                  Image.asset(currentMenuInfo.imageSource, scale: 2.0),
                  SizedBox(
                    height: 4,
                  ),
                  Text(currentMenuInfo.title,
                      style: TextStyle(
                          fontFamily: 'avenir',
                          color: CustomColors.primaryTextColor,
                          fontSize: 14)),
                ],
              ),
              // VerticalDivider(
              //   color: CustomColors.dividerColor,
              //   thickness: 5,
              // ),
            ],
          ),
        );
      },
    );
  }
}
