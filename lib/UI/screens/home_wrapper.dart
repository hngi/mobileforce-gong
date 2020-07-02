import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'home_page.dart';
import '../widgets/quotesTab/quoteTab.dart';
import '../../services/navigation/page_transitions/animations.dart';

class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomePage(),
           Align(
             alignment: Alignment.bottomCenter,
             child: Visibility(
               visible: true, child: LogoAnimation(
                 milliseconds: 1900,
                 color: Colors.transparent,
                 child: QuoteTab()))),
                 
                 ],
      ),
    );
  }
}