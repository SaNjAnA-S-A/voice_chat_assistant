import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_chat_assistant/backend.dart';
import 'package:voice_chat_assistant/chat.dart';
import 'package:flutter_tts/flutter_tts.dart';

class UIScreen extends StatefulWidget {
  const UIScreen({super.key});
  @override
  State<UIScreen> createState() => _UIScreenState();
}

class _UIScreenState extends State<UIScreen> {
  var text = "Hold to speak";
  var hold = false;
  final List<Chat> messages = [];
  var scrollController = ScrollController();
  final FlutterTts flutterTts = FlutterTts();

  var chatmsg;

  SpeechToText speechToText = SpeechToText();

  scroll() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: AvatarGlow(
          glowRadiusFactor: 75.0,
          animate: hold,
          duration: const Duration(milliseconds: 2000),
          glowColor: Colors.black,
          repeat: true,
          child: GestureDetector(
            onTapDown: (details) async {
              if (!hold) {
                var present = await speechToText.initialize();
                if (present) {
                  setState(() {
                    hold = true;
                    speechToText.listen(
                      onResult: (result) {
                        setState(() {
                          text = result.recognizedWords;
                        });
                      },
                    );
                  });
                }
              }
            },
            onTapUp: (details) async {
              setState(() {
                hold = false;
              });
              speechToText.stop();

              messages.add(Chat(text: text, type: ChatType.user));
              var message = await PassApi.passInput(text);
              setState(() {
                messages.add(Chat(text: message, type: ChatType.bot));
              });
            },
            child: CircleAvatar(
              radius: 35,
              backgroundColor: const Color.fromARGB(255, 232, 95, 95),
              child: Icon(hold ? Icons.mic : Icons.mic_none),
            ),
          ),
        ),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.teal,
            title: const Text(
              "Voice Assistant",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 180, 230, 225)),
            )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(
                    color: hold ? Colors.black87 : Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 28),
              ),
              const SizedBox(height: 12),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 180, 230, 225),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            chatmsg = messages[index];

                            return chat(
                                chattext: chatmsg.text, type: chatmsg.type);
                          }))),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  var speak = chatmsg.text;
                  flutterTts.speak(speak);
                },
                child: const Text('Press to listen!',
                    style: TextStyle(color: Colors.teal)),
              ),
              const Text(
                "Developed by Sanjana",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ],
          ),
        ));
  }

  Widget chat({required chattext, required ChatType? type}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: type == ChatType.bot
              ? Color.fromARGB(255, 227, 177, 198)
              : Colors.teal,
          child: type == ChatType.bot
              ? const Icon(Icons.computer, color: Colors.white)
              : const Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: type == ChatType.bot
                  ? Color.fromARGB(255, 227, 177, 198)
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            ),
            child: Text("$chattext",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                )),
          ),
        ),
      ],
    );
  }
}
