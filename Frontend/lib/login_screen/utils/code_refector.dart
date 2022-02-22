import 'package:best_flutter_ui_templates/login_screen/utils/exports.dart';

// custom text widget
Widget customText({required String txt, required TextStyle style}) {
  return Text(
    txt,
    style: style,
  );
}

// TextField
Widget customTextField({required String label, required String hint}) {
  return TextField(
    decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        )),
    keyboardType: TextInputType.multiline,
  );
}
