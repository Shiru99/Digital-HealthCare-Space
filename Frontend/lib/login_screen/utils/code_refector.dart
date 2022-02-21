import 'package:best_flutter_ui_templates/login_screen/utils/exports.dart';

// custom text widget
Widget customText({required String txt, required TextStyle style}) {
  return Text(
    txt,
    style: style,
  );
}

// inkwell buttons pic
Widget InkwellButtons({
  required Image image,
}) {
  return Expanded(
    child: Container(
      width: 170,
      height: 60,
      child: image,
    ),
  );
}

// sign up button
Widget SignUpContainer({required String st}) {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
      color: AppColors.kDarkBack,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: customText(
          txt: st,
          style: const TextStyle(
            color: AppColors.kDarkBack,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          )),
    ),
  );
}

// rich text
TextSpan RichTextSpan({required String one, required String two}) {
  return TextSpan(children: [
    TextSpan(
        text: one,
        style: TextStyle(fontSize: 13, color: AppColors.kDarkBack)),
    TextSpan(
        text: two,
        style: TextStyle(
          fontSize: 13,
          color: AppColors.kDarkBack,
        )),
  ]);
}

// TextField
Widget CustomTextField({required String Lone, required String Htwo}) {
  return TextField(
    decoration: InputDecoration(
        labelText: Lone,
        hintText: Htwo,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
        // border: const OutlineInputBorder(
        //     borderSide: BorderSide(
        //   width: 5,
        //   color: AppColors.kDarkblack,
        //   style: BorderStyle.solid,
        // ))
        ),
    // autofocus: true,
    keyboardType: TextInputType.multiline,
  );
}
