import 'dart:io';

import 'package:file_storage_mini_project/home/file_service/file_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() =>
      _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _fileService = FileService();

  List<Directory> _listOfFolder = [];

  List<File> _listofFile = [];
  String _currentLocation = "";

  void _loadFileandFolder(String path) async {
    _listOfFolder = await _fileService
        .getListOfFolder(path);
    _listofFile = await _fileService
        .getListOfFile(path);
    print("lenght ${_listofFile.length}");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFileandFolder(_currentLocation);
  }

  @override
  void didUpdateWidget(
    covariant Homepage oldWidget,
  ) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _loadFileandFolder(_currentLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Explorer"),
        actions: [
          IconButton(
            tooltip: "Create new folder",
            onPressed: () async {
              await _fileService.createFolder(
                "This is testing${DateTime.now().millisecondsSinceEpoch}",
              );
              _loadFileandFolder(
                _currentLocation,
              );
            },
            icon: Icon(Icons.create_new_folder),
          ),
          IconButton(
            tooltip: "Create new file",
            onPressed: () async {
              await _fileService.writeFile(
                "contents",
                "This is testing${DateTime.now().millisecondsSinceEpoch}",
              );
              _loadFileandFolder(
                _currentLocation,
              );
            },
            icon: Icon(Icons.note_add_outlined),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemBuilder: (_, index) {
              final Directory directory =
                  _listOfFolder[index];
              return ListTile(
                leading: Icon(
                  Icons.folder_copy_outlined,
                ),
                title: Text(
                  directory.path.split("/").last,
                ),
                subtitle: Text(
                  directory
                      .statSync()
                      .changed
                      .toString(),
                ),
              );
            },
            itemCount: _listOfFolder.length,
          ),
          SliverToBoxAdapter(child: Divider()),
          SliverList.builder(
            itemBuilder: (_, index) {
              print("index is $index");
              final File file =
                  _listofFile[index];
              return ListTile(
                leading: Icon(
                  Icons.folder_copy_outlined,
                ),
                title: Text(
                  file.path.split("/").last,
                ),
                subtitle: Text(
                  file
                      .statSync()
                      .changed
                      .toString(),
                ),
              );
            },
            itemCount: _listofFile.length,
          ),
        ],
      ),
    );
  }
}
