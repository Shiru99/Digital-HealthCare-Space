import 'package:digital_healthcare_space/login_screen/utils/exports.dart';
import 'package:digital_healthcare_space/navigation_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kLightPink,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),

                    Image.asset("assets/images/img1.png"),
                    const SizedBox(
                      height: 30,
                    ),
                    customText(
                        txt: "Welcome",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    customText(
                        txt:
                            "Please login or sign up to continue using our app.",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        )),

                    const SizedBox(height: 20),
                    customTextField(label: "Email", hint: "Email"),
                    const SizedBox(height: 20),
                    customTextField(label: "Password", hint: "Password"),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: _value,
                          onChanged: (newValue) {
                            setState(() {
                              _value = newValue!;
                            });
                            const Text(
                              "Remember me",
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.kDarkBack),
                            );
                          },
                        ),
                        const TextButton(
                          onPressed: null,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 16,
                        top: 16,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NavigationHomeScreen()
                              // builder: (context) => WelcomeScreen()
                              ));
                        },
                        child: Container(
                          height: 58,
                          padding: EdgeInsets.only(
                            left: 56.0,
                            right: 56.0,
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38.0),
                            color: AppColors.kDarkBack,
                          ),
                          child: Text(
                            "Let's Connect",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

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
