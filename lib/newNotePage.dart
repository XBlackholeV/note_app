// File name: newNotePage.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/clients/textEditorController.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final NoteAppTextEditorController noteAppTextEditorController = Get.put(
    NoteAppTextEditorController(),
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Column(
          children: [
            newNotePageTopBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.02,
                ),
                Container(
                  width: size.width * 0.9,
                  child: TextField(
                    onChanged: (titleValue) {
                      noteAppTextEditorController.title.value = titleValue;
                      print(noteAppTextEditorController.title.value);
                    },
                    maxLength: 32,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                    decoration: InputDecoration(
                      hintText: "Title",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.02,
                ),
                Container(
                  width: size.width * 0.9,
                  height: size.height * 0.7,
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    onChanged: (contentValue) {
                      noteAppTextEditorController.content.value = contentValue;
                      print(noteAppTextEditorController.content.value);
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                    decoration: InputDecoration(
                      hintText: "Type something here...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey,
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

class newNotePageTopBar extends StatefulWidget {
  const newNotePageTopBar({super.key});

  @override
  State<newNotePageTopBar> createState() => _newNotePageTopBarState();
}

class _newNotePageTopBarState extends State<newNotePageTopBar> {
  final NoteAppTextEditorController noteAppTextEditorController = Get.put(
    NoteAppTextEditorController(),
  );
  final box = GetStorage();
  void saveNote() {
    noteAppTextEditorController.noteTitle
        .add(noteAppTextEditorController.title.value);
    noteAppTextEditorController.noteContent
        .add(noteAppTextEditorController.content.value);
    var test =
        box.write('noteTitle', noteAppTextEditorController.noteTitle.value);
    print("Test = ${test}");
    box.write('noteContent', noteAppTextEditorController.noteContent.value);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.08,
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.02,
          ),
          InkWell(
            onTap: () {
              Get.back();
              print(noteAppTextEditorController.noteContent.value);
            },
            child: Container(
              width: size.width * 0.08,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.8,
          ),
          InkWell(
            onTap: () {
              saveNote();
            },
            child: Container(
              width: size.width * 0.1,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.save,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
