import 'dart:async';

import 'package:bubble_overlay/bubble_overlay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final BubbleOverlay bubbleOverlay = BubbleOverlay();
  bool alternateColor = false;

  void setMiddleTextCounter() {
    int time = 0;
    if (bubbleOverlay.serviceCreated)
      bubbleOverlay
          .setCallback(Timer.periodic(Duration(milliseconds: 500), (timer) {
        time++;
        if (bubbleOverlay.serviceCreated)
          bubbleOverlay.updateMiddleText('$time');
      }));
  }

  void setBottomTextHelloWorld() {
    if (bubbleOverlay.serviceCreated) {
      bubbleOverlay.removeCallback();
      bubbleOverlay.updateBottomText('Hello World');
    }
  }

  void closeBubble() {
    if (bubbleOverlay.serviceCreated) {
      bubbleOverlay.removeCallback();
      bubbleOverlay.closeBubble();
    }
  }

  void updateTextAndBgColor() {
    if (bubbleOverlay.serviceCreated) {
      bubbleOverlay.removeCallback();
      String textColor = alternateColor ? '#000000' : '#ffffff';
      String bgColor = alternateColor ? '#ffffff' : '#000000';
      bubbleOverlay.updateMiddleTextColor(textColor);
      bubbleOverlay.updateTopTextColor(textColor);
      bubbleOverlay.updateBottomTextColor(textColor);
      bubbleOverlay.updateBackgroundColor(bgColor);
      alternateColor = !alternateColor;
    }
  }

  void setTopText() {
    if (bubbleOverlay.serviceCreated) {
      bubbleOverlay.removeCallback();
      bubbleOverlay.updateTopText('Set Bubble Title');
    }
  }

  void setTopIcon() async {
    String url =
        'https://meterpreter.org/wp-content/uploads/2018/09/flutter.png';
    http.get(url).then((response) {
      if (response != null)
        bubbleOverlay.updateTopIconWithBytes(response.bodyBytes);
    });
  }

  void setBottomIcon() async {
    String url =
        'https://github.githubassets.com/images/modules/open_graph/github-mark.png';
    http.get(url).then((response) {
      if (response != null)
        bubbleOverlay.updateBottomIconWithBytes(response.bodyBytes);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Bubble Overlay')),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                        child: Text('Open Bubble Overlay'),
                        onPressed: () => bubbleOverlay.openBubble()),
                    RaisedButton(
                      onPressed: closeBubble,
                      child: Text('Close Bubble'),
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: setTopText,
                  child: Text('Set Bubble Top Text'),
                ),
                RaisedButton(
                  onPressed: setMiddleTextCounter,
                  child: Text('Set Middle Text Counter'),
                ),
                RaisedButton(
                  onPressed: setBottomTextHelloWorld,
                  child: Text('Set Bottom Text "Hello World"'),
                ),
                RaisedButton(
                  onPressed: updateTextAndBgColor,
                  child: Text('Update text and background color'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text('Set Top Icon'),
                      onPressed: setTopIcon,
                    ),
                    RaisedButton(
                      child: Text('Set Bottom Icon'),
                      onPressed: setBottomIcon,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
