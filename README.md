# voice_chat_assistant

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Flutter_Voice_Assistance
Voice chat assistance/sentence framing around a word android app

Packages used: 
cupertino_icons: ^1.0.2
avatar_glow: ^3.0.1
speech_to_text: ^6.6.1
http: ^1.2.0
flutter_tts: ^3.8.5

The device used ‘Pixel 7 Pro API 34’. Functional code is written is 4 files in lib directory. The backend api passing is done in backend.dart. In chat.dart, a class with the message and its type class is declared. In main.dart, the root code of this application is present which is overriding with the UIScreen(). UIScreen contains most of the code. The app takes voice input, converts it into text and processes it and gives the output displays text and voice (on pressing the button). It is mainly targeted for stress relief and a mood uplifting app where random sentences are generated with any given word.

There were two functionalities developed in this app:
1.	Bot framing sentences around a given word.
2.	Interactive bot for answering wh- questions and conversational. (only if API has the access quota)
The outputs are shown below and video clips are attached.

1.	I have implemented a bot for framing sentences around a given word as shown below. Just say a word and it frames a sentence with the same. Error handling is also performed as shown below.
  
<img width="163" alt="image" src="https://github.com/SaNjAnA-S-A/Flutter_Voice_Assistance/assets/45251608/8f9118f4-8f88-421d-a8af-f8ed30ec0c6d">

2.	Interactive bot for answering wh- questions and conversational.

   <img width="162" alt="image" src="https://github.com/SaNjAnA-S-A/Flutter_Voice_Assistance/assets/45251608/0a0ddef0-fe8c-4ab0-96af-2d9ccff6157c">

Unfortunately, the openAI API that I was using got out of limit for free access, so I could not continue with access, but I have recorded output for the same. 
 
I mentioned the same in the output through the code and it still runs if the API access is acquired. If the access is not there then, there I have implemented a bot for framing sentences around a given word as shown below. Just say a word and it frames a sentence with the same as shown above.


