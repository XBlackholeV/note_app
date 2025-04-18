// File name: textEditor.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/clients/textEditorController.dart';

class Texteditor extends StatefulWidget {
  final int noteID;
  // final String noteTitle;
  // final String noteContent;
  const Texteditor({
    super.key,
    required this.noteID,
  });

  @override
  State<Texteditor> createState() => _TexteditorState();
}

class _TexteditorState extends State<Texteditor> {
  final NoteAppTextEditorController noteAppTextEditorController =
      Get.put(NoteAppTextEditorController());
  final box = GetStorage();
  var title = '';
  var content = '';
  var titleArray = [];
  var contentArray = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      titleArray = box.read('noteTitle');
      contentArray = box.read('noteContent');
      print("titleArray: $titleArray");
      print("contentArray: $contentArray");
    });
  }

  @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     noteAppTextEditorController.noteTitle.value[widget.noteID] = title;
  //     print('denemeeeee ${noteAppTextEditorController.noteTitle}');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("denemeeeeeeeeeeeee $title");
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Column(
          children: [
            TextEditorTopBar(
              noteID: widget.noteID,
              noteTitle: title,
              noteContent: content,
            ),
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
                      title = titleValue;
                      print(title);
                    },
                    maxLength: 32,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                    decoration: InputDecoration(
                      hintText: "${titleArray[widget.noteID]}",
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
                    onChanged: (titleValue) {
                      title = titleValue;
                      print(title);
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                    decoration: InputDecoration(
                      hintText: "${contentArray[widget.noteID]}",
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

class TextEditorTopBar extends StatefulWidget {
  final int noteID;
  final String noteTitle;
  final String noteContent;
  const TextEditorTopBar(
      {super.key,
      required this.noteID,
      required this.noteContent,
      required this.noteTitle});

  @override
  State<TextEditorTopBar> createState() => _TextEditorTopBarState();
}

class _TextEditorTopBarState extends State<TextEditorTopBar> {
  void updateNote() {
    final box = GetStorage();
    var titleArray = box.read('noteTitle') ?? [];
    var contentArray = box.read('noteContent') ?? [];

    titleArray[widget.noteID] = widget.noteTitle;

    contentArray[widget.noteID] = widget.noteContent;
    box.write('noteTitle', titleArray);
    box.write('noteContent', contentArray);
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
              updateNote();
              Get.back();
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
