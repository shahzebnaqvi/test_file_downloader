import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_filedownloader/downloader/downloader_controller.dart';
import 'dart:convert';


class DonwloaderView extends StatelessWidget {
   DonwloaderView({super.key});
 DonwloaderController donwloaderControl =
      Get.put(DonwloaderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {

          donwloaderControl.downloadFile('https://www.dwsamplefiles.com/?dl_id=176','aaas-file.pdf');


          }, child: Text("Download the File"))
        ],
      ),
    );
  }
}
