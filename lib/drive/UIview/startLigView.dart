import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../driveAppTheme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audio_cache.dart';

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class StartLigView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final String mp3;
  final String text;
  final String img;
  static AudioCache player = AudioCache(prefix: 'audio/');

  const StartLigView(
      {Key key,
      this.animationController,
      this.animation,
      this.mp3,
      this.text,
      this.img})
      : super(key: key);

  Future<Null> _load() async {
    player.play(mp3);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 0, bottom: 2),
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      splashColor:
                          FintnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                      onTap: () {
                        _load();
                      },
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FintnessAppTheme.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: FintnessAppTheme.grey
                                          .withOpacity(0.4),
                                      offset: Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.topLeft,
                                children: <Widget>[
                                  /* ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                child: SizedBox(
                                  height: 74,
                                  child: AspectRatio(
                                    aspectRatio: 1.714,
                                    child: Image.asset(
                                        "assets/fitness_app/back.png"),
                                  ),
                                ),
                              ),*/
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 100,
                                                right: 16,
                                                top: 16,
                                                bottom: 0),
                                            child: Text(
                                              text,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily:
                                                    FintnessAppTheme.fontName,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20,
                                                letterSpacing: 0.0,
                                                color:
                                                    FintnessAppTheme.darkText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 100,
                                          bottom: 12,
                                          top: 4,
                                          right: 16,
                                        ),
                                        child: Text(
                                          "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily:
                                                FintnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            letterSpacing: 0.0,
                                            color: FintnessAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 6,
//                        bottom: 2,
                            child: SizedBox(
                              width: 68,
                              height: 67,
                              child: Image.asset(img),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
