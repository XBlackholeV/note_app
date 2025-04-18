// File name: main.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:note_app/clients/textEditorController.dart';
import 'package:note_app/newNotePage.dart';
import 'package:note_app/textEditor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Note App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MainCollector(),
    );
  }
}

class MainCollector extends StatefulWidget {
  const MainCollector({super.key});

  @override
  State<MainCollector> createState() => _MainCollectorState();
}

class _MainCollectorState extends State<MainCollector> {
  final NoteAppTextEditorController noteAppTextEditorController = Get.put(
    NoteAppTextEditorController(),
  );
  @override
  void initState() {
    super.initState();
    if (noteAppTextEditorController.noteTitle.isNotEmpty) {
      noteAppTextEditorController.isNote.value = true;
    } else {
      noteAppTextEditorController.isNote.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          "Note App",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(NewNotePage(),
              transition: Transition.rightToLeft, duration: 1500.milliseconds);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            noteAppTextEditorController.isNote.value
                ? Obx(() {
                    return Container(
                      child: ListView.builder(
                        itemCount: noteAppTextEditorController.noteTitle.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  print(index);
                                  print(
                                      'denemeeeee ${noteAppTextEditorController.noteTitle}');
                                  Get.to(
                                    Texteditor(
                                      noteID: index,
                                    ),
                                    transition: Transition.rightToLeft,
                                    duration: 1500.milliseconds,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: Offset(4, 4),
                                        ),
                                      ]),
                                  width: size.width * 0.8,
                                  height: size.height * 0.175,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Container(
                                            width: size.width * 0.6,
                                            child: Text(
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                              "${noteAppTextEditorController.noteTitle[index]}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Container(
                                            width: size.width * 0.6,
                                            child: Text(
                                              "${noteAppTextEditorController.noteContent[index]}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 5,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      width: size.width,
                      height: size.height / 1.2,
                    );
                  })
                : Column(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        child: Center(
                          child: Image.asset("assets/img/bgimgnote.png"),
                        ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Center(
                          child: Text(
                            "Make a note using the + button.",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
