import 'package:digital_healthcare_space/health_space/health_space_theme.dart';
import 'package:flutter/material.dart';

class TitleView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  final Function() updateParent;

  const TitleView(
      {Key? key,
      this.animationController,
      this.animation,
      required this.updateParent})
      : super(key: key);

  @override
  State<TitleView> createState() => _TitleViewState();
}

class _TitleViewState extends State<TitleView> {
  Future updatePersonalDetails() async {
    print("calling updateParent");
    widget.updateParent();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Body measurement',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        letterSpacing: 0.5,
                        color: FitnessAppTheme.lightText,
                      ),
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 38,
                            width: 26,
                            child: IconButton(
                              icon: const Icon(Icons.edit,
                                  color: FitnessAppTheme.darkText,
                                  size: 21.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes'),
                              onPressed: () {
                                updatePersonalDetails();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
