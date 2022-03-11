import 'package:digital_healthcare_space/app_theme.dart';

import 'package:digital_healthcare_space/health_space/health_space_theme.dart';
import 'package:digital_healthcare_space/health_space/personal_info/body_measurement.dart';
import 'package:digital_healthcare_space/health_space/personal_info/info_title_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyPersonalDataScreen extends StatefulWidget {
  final String email;
  final String userID;
  const MyPersonalDataScreen({
    Key? key,
    this.animationController,
    required this.email,
    required this.userID,
  }) : super(key: key);

  final AnimationController? animationController;
  @override
  _MyPersonalDataScreenState createState() => _MyPersonalDataScreenState();
}

class _MyPersonalDataScreenState extends State<MyPersonalDataScreen>
    with TickerProviderStateMixin {
  refresh() {
    print("Edit button pressed");
    setState(() {
      editingUserDetails = true;
    });
  }

  var editingUserDetails = false;
  Animation<double>? topBarAnimation;
  Animation<double>? animation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _bloodGroup = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _contactDetails = TextEditingController();
  final TextEditingController _EmergencyContactDetails =
      TextEditingController();

  final TextEditingController _password = TextEditingController();
  bool _passwordVisible = false;

  signInTheUserGP(String email, String password) async {
    if (_signInFormKey.currentState!.validate()) {
      setState(() {
        editingUserDetails = false;
      });

      try {
        /**
         * Update User Details
         */
        toastMessage("Updated successfully");
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        toastMessage(e.toString());
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController!,
        curve: const Interval((1 / 2) * 5, 1.0, curve: Curves.fastOutSlowIn)));
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 5;

    listViews.add(
      TitleView(
        updateParent: refresh,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 4, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      BodyMeasurementView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 5, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            editingUserDetails ? getEditContainer() : getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 12),
                                  child: Text(
                                    'Personal Info',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: AppTheme.darkText,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget getEditContainer() {
    _bloodGroup.text = 'O -ve';
    _age.text = "79";
    _gender.text = "Female";
    _contactDetails.text = "9922992299";
    _email.text = widget.email;
    _weight.text = "99";
    _height.text = "5.5";
    _EmergencyContactDetails.text = "9900990099";
    _password.text = "abcABC123@";

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F3F8),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 75, left: 20, right: 20),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(68.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: FitnessAppTheme.grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Form(
                            key: _signInFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: "Blood Group",
                                        hintText: "O -ve",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        )),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    controller: _bloodGroup,
                                    validator: (bloodGroup) {
                                      if (bloodGroup!.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _bloodGroup.text = value!;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: "Weight",
                                        hintText: "99",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        )),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    controller: _weight,
                                    validator: (weight) {
                                      if (weight!.isEmpty) {
                                        return 'Please enter some number';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _weight.text = value!;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: "Height",
                                        hintText: "99",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        )),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    controller: _height,
                                    validator: (height) {
                                      if (height!.isEmpty) {
                                        return 'Please enter some number';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _height.text = value!;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: "Age",
                                        hintText: "99",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        )),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    controller: _age,
                                    validator: (age) {
                                      if (age!.isEmpty) {
                                        return 'Please enter some number';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _age.text = value!;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: "gender",
                                        hintText: "Male/Female",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        )),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    controller: _gender,
                                    validator: (gender) {
                                      if (gender!.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _gender.text = value!;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: "Contact Details",
                                        hintText: "contact details",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        )),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    controller: _contactDetails,
                                    validator: (contactDetails) {
                                      if (contactDetails!.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _contactDetails.text = value!;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: "Contact Details",
                                        hintText: "contact details",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        )),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    controller: _EmergencyContactDetails,
                                    validator: (contactDetails) {
                                      if (contactDetails!.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _EmergencyContactDetails.text = value!;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: "Gmail",
                                        hintText: "john.doe@gmail.com",
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        )),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _email,
                                    validator: (email) {
                                      if (email!.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return EmailValidator.validate(email)
                                          ? null
                                          : "Invalid email address";
                                    },
                                    onSaved: (value) {
                                      _email.text = value!;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: TextFormField(
                                      // style: TextStyle(
                                      //   color: Colors.white,
                                      // ),
                                      obscureText: _passwordVisible,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        hintText:
                                            " a-z + A-Z + 0-9 + !@#\$&*~ ",
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible
                                                ? Icons
                                                    .visibility // Icons.lock,
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      textInputAction: TextInputAction.done,
                                      controller: _password,
                                      onFieldSubmitted: (_) =>
                                          FocusScope.of(context).unfocus(),
                                      validator: (password) {
                                        Pattern pattern =
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                        RegExp regex =
                                            RegExp(pattern.toString());
                                        if (password!.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        if (password.length < 8) {
                                          return 'atleast 8 characters';
                                        }
                                        if (!regex.hasMatch(password)) {
                                          return 'week password';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        _password.text = value!;
                                      }),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 16,
                        top: 16,
                      ),
                      child: InkWell(
                        onTap: () {
                          signInTheUserGP(_bloodGroup.text, _password.text);
                        },
                        child: Container(
                          height: 58,
                          padding: const EdgeInsets.only(
                            left: 56.0,
                            right: 56.0,
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38.0),
                            color: const Color(0xff132137),
                          ),
                          child: const Text(
                            "Update Details",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),

                    //Text("data"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      fontSize: 16.0);
}
