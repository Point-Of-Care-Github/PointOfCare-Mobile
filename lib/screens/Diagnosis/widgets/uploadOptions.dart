import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/report.dart';

class UploadOptions extends StatefulWidget {
  @override
  State<UploadOptions> createState() => _UploadOptionsState();
}

class _UploadOptionsState extends State<UploadOptions> {
  File? image;
  Map<String, dynamic>? results;
  bool _isLoading = false;
  var res;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var pickedImage = await picker.pickImage(source: media);
    if (pickedImage == null) return;

    final croppedImage = await ImageCropper()
        .cropImage(sourcePath: pickedImage.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ], uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Crop Image',
        aspectRatioLockEnabled: false,
      ),
    ]);

    if (croppedImage == null) return;

    final croppedFile = File(croppedImage.path);

    setState(() {
      this.image = croppedFile;
    });

    // File file = File(imageFile!.path);

    // setState(() {
    //   image = file;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: deviceSize.width * 0.3,
                    height: deviceSize.height * 0.15,
                    child: DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: [5, 5],
                        color: Colors.grey,
                        strokeWidth: 2,
                        child: Center(
                          child: TextButton.icon(
                              icon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.collections,
                                    size: 35,
                                    color: Colors.grey,
                                  ),
                                  Text('upload xray',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                              label: Text(''),
                              onPressed: () {
                                getImage(ImageSource.gallery);
                              }),
                        )),
                  ),
                  Container(
                    width: deviceSize.width * 0.3,
                    height: deviceSize.height * 0.15,
                    child: DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: [5, 5],
                        color: Colors.grey,
                        strokeWidth: 2,
                        child: Center(
                          child: TextButton.icon(
                              icon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 35,
                                    color: Colors.grey,
                                  ),
                                  Text('Take Photo',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                              label: Text(''),
                              onPressed: () {
                                getImage(ImageSource.camera);
                              }),
                        )),
                  ),
                ],
              ),
              // ignore: unnecessary_null_comparison
              SizedBox(
                height: 20,
              ),
              image != null
                  ? Container(
                      // margin: EdgeInsets.only(top: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Image.file(
                          //to show image, you type like this.
                          File(image!.path),
                          fit: BoxFit.cover,
                          // width: deviceSize.width * 0.7,
                          // height: deviceSize.height * 0.3,
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 50,
              ),

              //next button
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<Results>(context, listen: false)
                        .diagnose(image)
                        .then((_) {
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.pushNamed(context, '/result-screen',
                          arguments: {'image': image!.path});
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFB9A0E6),
                              Color(0xFF8587DC),
                            ]),
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      width: deviceSize.width * 0.85,
                      height: 52,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Submit',
                          style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
