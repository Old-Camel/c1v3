import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

import '../driveAppTheme.dart';

class Light extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation mainScreenAnimation;

  const Light(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);
  @override
  _LightState createState() => _LightState();
}

class _LightState extends State<Light>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Map> areaListData = [
  {"text":"夜间在没有路灯照明不良条件下行驶","mp3":"l-1.mp3"},
  {"text":"夜间在有路灯照明良好的道路下行驶","mp3":"l-2.mp3"},
  {"text":"同方向近距离紧跟前车行驶","mp3":"l-3.mp3"},
  {"text":"夜间在窄路、窄桥，与非机动车会车","mp3":"l-4.mp3"},
  {"text":"现在通过路口","mp3":"l-5.mp3"},
  {"text":"夜间通过急弯、坡路、拱桥、人行横道或没有交通信号灯控制的路口","mp3":"l-6.mp3"},
  {"text":"超车","mp3":"l-7.mp3"},
  {"text":"临时靠边停车","mp3":"l-8.mp3"},
  {"text":"道路上发生故障车辆难以移动","mp3":"l-9.mp3"}
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: GridView(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    areaListData.length,
                    (index) {
                      var count = areaListData.length;
                      var animation = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController.forward();
                      return LightView(
                        text: areaListData[index]["text"],
                        mp3: areaListData[index]["mp3"],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 8/3,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LightView extends StatelessWidget {
  final String text;
  final String mp3;
  final AnimationController animationController;
  final Animation animation;
  static AudioCache player = AudioCache(prefix: 'audio/');
  Future<Null> _load() async {
    player.play(mp3);
  }

  const LightView({
    Key key,
    this.text,
    this.mp3,
    this.animationController,
    this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
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
                      color: FintnessAppTheme.grey.withOpacity(0.4),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 5.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  splashColor: FintnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                  onTap: () { _load();},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 6, right: 6),
                        child: Text(
                          text,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily:
                            FintnessAppTheme.fontName,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            letterSpacing: 0.0,
                            color:
                            FintnessAppTheme.darkText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
