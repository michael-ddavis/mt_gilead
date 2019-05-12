import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mt_gilead/app.dart';
import 'package:mt_gilead/utils/state_widget.dart';

void main() {
  StateWidget stateWidget = new StateWidget(
    child: new AppRootWidget(),
  );
  runApp(stateWidget);
}
