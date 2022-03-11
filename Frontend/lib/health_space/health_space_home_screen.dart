import 'package:digital_healthcare_space/health_space/Diet_info/my_diet_screen.dart';
import 'package:digital_healthcare_space/health_space/exercise_info/my_exercise_screen.dart';
import 'package:digital_healthcare_space/health_space/health_info/my_health_screen.dart';
import 'package:digital_healthcare_space/health_space/personal_info/my_personal_info_screen.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'health_space_theme.dart';

import 'package:digital_healthcare_space/health_space/bottom_navigation_view/tabIcon_data.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  final String email;
  final String userID;
  const FitnessAppHomeScreen({
    Key? key,
    required this.email,
    required this.userID,
  }) : super(key: key);

  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyHealthScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            // IOT DEVICE - Health info
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyHealthScreen(animationController: animationController);
                });
              });
            }
            // Diet info
            else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDietScreen(animationController: animationController);
                });
              });
            }
            // Exercise info
            else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = MyExerciseScreen(
                      animationController: animationController);
                });
              });
            }
            // Personal Info
            else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = MyPersonalDataScreen(
                    animationController: animationController,
                    email: widget.email,
                    userID: widget.userID,
                  );
                });
              });
            }
          },
        ),
      ],
    );
  }
}
