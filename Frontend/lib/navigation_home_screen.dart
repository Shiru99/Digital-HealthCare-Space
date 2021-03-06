import 'package:digital_healthcare_space/app_theme.dart';
import 'package:digital_healthcare_space/side_drawer/drawer_user_controller.dart';
import 'package:digital_healthcare_space/side_drawer/home_drawer.dart';
import 'package:digital_healthcare_space/feedback_screen.dart';
import 'package:digital_healthcare_space/health_space/health_space_home_screen.dart';
import 'package:digital_healthcare_space/help_screen.dart';
import 'package:digital_healthcare_space/invite_friend_screen.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  final String email;
  final String userID;
  const NavigationHomeScreen(
      {Key? key, required this.email, required this.userID})
      : super(key: key);

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = FitnessAppHomeScreen(email: widget.email, userID: widget.userID,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = FitnessAppHomeScreen(email: widget.email, userID: widget.userID,);
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = const InviteFriend();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = const HelpScreen();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = const InviteFriend();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          screenView = const FeedbackScreen();
        });
      } else {
        //do in your way......
      }
    }
  }
}
