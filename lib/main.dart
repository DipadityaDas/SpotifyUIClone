import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:line_icons/line_icons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Music UI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageSetup createState() => _MyHomePageSetup();
}

class _MyHomePageSetup extends State<MyHomePage> {
  bool isHeartPressed = false;
  bool isPlayPressed = false;
  // double _value = 0;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
    // ignore: deprecated_member_use
    advancedPlayer.durationHandler = (d) => setState(() => _duration = d);
    // ignore: deprecated_member_use
    advancedPlayer.positionHandler = (p) => setState(() => _position = p);
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  double setChanged() {
    Duration newDuration = Duration(seconds: 0);
    advancedPlayer.seek(newDuration);
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 40,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.brown,
              Colors.black87,
            ],
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    LineIcons.angle_down,
                    color: Colors.white,
                    size: 24,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "PLAYING FROM ALBUM",
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Dil Bechara',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontFamily: "ProximaNova",
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    LineIcons.ellipsis_v,
                    color: Colors.white,
                    size: 24,
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      "https://i.scdn.co/image/ab67616d0000b273f3582107f127c2765fafb431"),
                ),
                width: 325,
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Dil Bechara",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "ProximaNova",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 0.2,
                          ),
                        ),
                        Text(
                          "A. R. Rahman",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: "ProximaNovaThin",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: (isHeartPressed == true)
                          ? Icon(
                              LineIcons.heart,
                              color: Colors.green,
                              size: 30,
                            )
                          : Icon(
                              LineIcons.heart_o,
                              color: Colors.grey.shade400,
                              size: 30,
                            ),
                      onPressed: () {
                        setState(() {
                          isHeartPressed =
                              (isHeartPressed == false) ? true : false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    width: double.infinity,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.grey.shade600,
                        activeTickMarkColor: Colors.white,
                        thumbColor: Colors.white,
                        trackHeight: 3,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 4,
                        ),
                      ),
                      child: Slider(
                        value: (_position.inSeconds.toDouble() !=
                                _duration.inSeconds.toDouble())
                            ? _position.inSeconds.toDouble()
                            : setChanged(),
                        min: 0,
                        max: _duration.inSeconds.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            seekToSecond(value.toInt());
                            value = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${_position.inMinutes.toInt()}:${(_position.inSeconds % 60).toString().padLeft(2, "0")}",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: "ProximaNovaThin",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${_duration.inMinutes.toInt()}:${(_duration.inSeconds % 60).toString().padLeft(2, "0")}",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontFamily: "ProximaNovaThin",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 22, right: 22),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      LineIcons.random,
                      color: Colors.grey.shade400,
                    ),
                    Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 40,
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      child: Center(
                        child: IconButton(
                          iconSize: 70,
                          alignment: Alignment.center,
                          icon: (isPlayPressed == true)
                              ? Icon(
                                  Icons.pause_circle_filled,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.play_circle_filled,
                                  color: Colors.white,
                                ),
                          onPressed: () {
                            setState(() {
                              isPlayPressed =
                                  isPlayPressed == false ? true : false;
                              if (isPlayPressed == true) {
                                print("Playing .....");
                                audioCache.play(
                                  'Dil Bechara - Title Song.mp3',
                                );
                              } else {
                                print("Paused .....");
                                advancedPlayer.pause();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 40,
                    ),
                    Icon(
                      LineIcons.repeat,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 22, right: 22),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      LineIcons.desktop,
                      color: Colors.grey.shade400,
                    ),
                    Icon(
                      LineIcons.list_alt,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
