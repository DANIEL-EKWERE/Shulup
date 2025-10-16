import 'package:flutter/widgets.dart';

// This prevents the soft keyboard from showing up
class NoKeyboardFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // Returning false blocks keyboard popup, but keeps hardware input
    return false;
  }
}
