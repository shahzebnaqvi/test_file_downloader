import 'dart:isolate';
import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

class DonwloaderController extends GetxController {
  final ReceivePort port = ReceivePort();
  static void downloadCallback(String id, status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  void downloadFile(String url, filename) async {
    // final status = await Permission.storage.request();
    // if (status.isGranted) {
    final externalDir = await getExternalStorageDirectory();
    final id = await FlutterDownloader.enqueue(
      fileName: "$filename",
      url: url,
      savedDir: externalDir!.path,
      showNotification: true,
      openFileFromNotification: true,
    );

    // } else {
    //   print('Permission Denied');
    // }
  }

  void onInit() {
    super.onInit();
    IsolateNameServer.registerPortWithName(
        port.sendPort, 'downloader_send_port');
    port.listen((dynamic data) {
      print("sani $data");
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus.values[data[1]];
      int progress = data[2]; 
          FlutterDownloader.open(taskId: id);
      if (progress == 100 && id != null) {
        Get.snackbar("progress", id);
          FlutterDownloader.open(taskId: id);
      }
      update();
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }
}
