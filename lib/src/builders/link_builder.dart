import 'package:flutter/gestures.dart';

import '../../global_coltroller.dart';
import 'builder.dart';

class LinkBuilder extends MarkdownElementBuilder {
  LinkBuilder(this.controller);
  final MarkDownConfig controller;
  @override
  final matchTypes = ['link'];

  @override
  GestureRecognizer? gestureRecognizer(element) {
    return TapGestureRecognizer()
      ..onTap = () => controller.linkTap(
          element.attributes['destination'], element.attributes['title']);
  }
}
