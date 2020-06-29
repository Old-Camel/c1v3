import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

import '../fintnessAppTheme.dart';

class AreaListView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation mainScreenAnimation;

  const AreaListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);
  @override
  _AreaListViewState createState() => _AreaListViewState();
}

class _AreaListViewState extends State<AreaListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Map> areaListData = [
  {"text":"1.起步（无语音)","mp3":null},
  {"text":"2.人行横道（无语音）","mp3":null},
  {"text":"3.超车路段","mp3":"r-1.mp3"},
  {"text":"4.路口右转弯","mp3":"r-2.mp3"},
  {"text":"5.公交站牌(无语音）","mp3":null},
  {"text":"6.会车路段","mp3":"r-3.mp3"},
  {"text":"7.掉头(无语音)","mp3":null},
  {"text":"8.加减档(无语音)","mp3":null},
  {"text":"9.学校(无语音)","mp3":null},
  {"text":"10.路口左转弯","mp3":"r-4.mp3"},
  {"text":"11.直线行驶路段","mp3":"r-5.mp3"},
  {"text":"12.直行通过路口","mp3":"r-6.mp3"},
  {"text":"13.变更车道路段","mp3":"r-7.mp3"},
  {"text":"14.掉头路段","mp3":"r-8.mp3"},
  {"text":"15.靠边停车路段","mp3":"r-9.mp3"},
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
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
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
                      return AreaView(
                        text: areaListData[index]["text"],
                        mp3: areaListData[index]["mp3"],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24.0,
                    crossAxisSpacing: 24.0,
                    childAspectRatio: 1.0,
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

class AreaView extends StatelessWidget {
  final String text;
  final String mp3;
  final AnimationController animationController;
  final Animation animation;
  static AudioCache player = AudioCache(prefix: 'audio/');
  Future<Null> _load() async {
    if(mp3!=null) {
      player.play(mp3);
    }
  }

  const AreaView({
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
                      blurRadius: 10.0),
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
                        padding: EdgeInsets.only(top: 0, left: 4, right: 0),
                        child: Text(
                          text,
                          textAlign: TextAlign.left,
                          style: TextStyle(

                            fontFamily:
                            FintnessAppTheme.fontName,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
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
