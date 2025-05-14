import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/app_snack_bar.dart';

class AppFunctions {
  Future<List<File>> pickImageFiles({bool allowMultiple = false}) async {
    List<File> selectedFiles = [];

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: FileType.image, // Restrict to images only
        allowMultiple: allowMultiple,
      );

      if (result != null) {
        // If multiple files are selected, iterate over the files
        if (allowMultiple) {
          // Handle multiple files
          for (var file in result.files) {
            File f = File(file.path!);
            if (await checkFileSize(f)) {
              selectedFiles.add(f); // Add the valid file to the list
            }
          }
        } else {
          // Handle single file (this is for when allowMultiple is false)
          File f = File(result.files.single.path!);
          if (await checkFileSize(f)) {
            selectedFiles.add(f); // Add the valid file to the list
          }
        }
      }
    } catch (e) {
      print('Error picking file: $e');
    }

    return selectedFiles; // Return the list of selected files (empty if no files selected)
  }


  Future<bool> checkFileSize(File file) async {
    // Get file size in bytes
    int fileSizeInBytes = await file.length();

    // 2 MB in bytes
    const int maxFileSizeInBytes = 2 * 1024 * 1024;

    if (fileSizeInBytes <= maxFileSizeInBytes) {
      print("File size is within the 2 MB limit.");
      return true;
    } else {
      AppSnackBar.error(message: "File size exceeds the 2 MB limit.");
      return false;
      // Handle file size too large scenario
    }
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll("#", ""); // Remove the # if present
    if (hex.length == 6) {
      hex = "FF$hex"; // Add full opacity if alpha is missing
    }
    return (Color(int.parse(hex, radix: 16)));
  }
}
