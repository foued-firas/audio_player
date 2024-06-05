import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerPage extends StatefulWidget {
  final String audioUrl;
  final String imageUrl;
  final String title;

  AudioPlayerPage({Key? key, required this.audioUrl, required this.imageUrl, required this.title}) : super(key: key);

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    setupAudio();
  }

  void setupAudio() async {
    await audioPlayer.play(UrlSource(widget.audioUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.imageUrl, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Now Playing: ${widget.title}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () => audioPlayer.resume(),
                  iconSize: 48,
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () => audioPlayer.pause(),
                  iconSize: 48,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    audioPlayer.stop();
                    Navigator.pop(context);
                  },
                  iconSize: 48,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
