// File name: textEditorController.dart

import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class NoteAppTextEditorController extends GetxController {
  final box = GetStorage();
  var isNote = false.obs;
  var noteTitle = ['Welcome to Note App!'].obs;
  var noteContent = ['Click this to make your first note!'].obs;
  var title = ''.obs;
  var content = ''.obs;
}
