import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText stt = SpeechToText();
  var test = '';
  var text = 'Hold the button and start speaking';
  var isListening = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: const Duration(microseconds: 2000),
        glowColor: bgColor,
        repeat: true,
        repeatPauseDuration: const Duration(microseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await stt.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  stt.listen(onResult: (result) {
                    setState(() {
                      print(result);
                      text = result.recognizedWords;
                    });
                  });
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            stt.stop();
          },
          child: CircleAvatar(
            backgroundColor: bgColor,
            radius: 35,
            child: Icon(
              isListening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
          leading: const Icon(
            Icons.sort_rounded,
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: bgColor,
          elevation: 0.0,
          title: const Text("Speech To Text",
              style: TextStyle(fontWeight: FontWeight.w600, color: textColor))),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
