import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

String url =
    'https://ddb4-2401-4900-1ca9-da76-78d2-7839-c6f8-e1d0.in.ngrok.io/predict';

class ImgPicker extends StatefulWidget {
  const ImgPicker({Key? key}) : super(key: key);

  @override
  State<ImgPicker> createState() => _ImgPicker();
}

class _ImgPicker extends State<ImgPicker> {
  File? image;
  List<XFile> multipleimage = [];
  String prediction = "upload to get prediction";
  var Status = 0;
  Future<void> pickimagefromgallery() async {
    final imagepicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imagepicked != null) {
      setState(() {
        Status = 0;
        image = File(imagepicked.path);
      });
    }
  }

  Future<void> pickimagefromcamera() async {
    final imagepicked =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagepicked != null) {
      setState(() {
        Status = 0;
        image = File(imagepicked.path);
      });
    }
  }

  Future<void> pickmultipleimage() async {
    List<XFile> imagepicked = await ImagePicker().pickMultiImage();
    setState(() {
      Status = 0;
      multipleimage.addAll(imagepicked);
    });
  }

  Future<String> sendImageToServer(File imageFile, String url) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));
    final image = await http.MultipartFile.fromPath('image', imageFile.path);

    request.files.add(image);
    print("initiating request..");
    final response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        Status = 200;
      });
      return response.stream.bytesToString();
    } else {
      throw Exception('Failed to upload image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 173, 162),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            image == null
                ? Image.asset(
                    'lib/images/imagePicker/SoilPhotograph.png',
                    height: 400,
                    width: 400,
                  )
                : Image.file(
                    image!,
                    height: 400,
                    width: 300,
                    fit: BoxFit.contain,
                  ),
            const SizedBox(
              height: 30,
            ),
            Text(prediction),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
                onPressed: () => pickimagefromgallery(),
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(220, 40)),
                    backgroundColor: MaterialStatePropertyAll(Colors.brown)),
                icon: SizedBox.square(
                  dimension: 35,
                  child: Icon(Icons.image),
                ),
                label: const Text(
                  'Pick Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () => pickimagefromcamera(),
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(220, 40)),
                    backgroundColor: MaterialStatePropertyAll(Colors.brown)),
                icon: SizedBox.square(
                  dimension: 35,
                  child: Icon(
                    Icons.camera_alt_rounded,
                  ),
                ),
                label: const Text(
                  'Open Camera',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
            const SizedBox(
              height: 10,
            ),
            image != null && Status != 200
                ? ElevatedButton.icon(
                    onPressed: () {
                      print("clicked");
                      if (image != null) {
                        print("image present");
                      } else {
                        print("image not present");
                      }
                      sendImageToServer(image!, url).then((response) {
                        // Handle the response from the server

                        print('Response: $response');
                        setState(() {
                          prediction = response;
                        });
                      }).catchError((error) {
                        print("error occured!!");
                        // Handle any errors that occur
                        print('Error: $error');
                      });
                    },
                    style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(220, 40)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.brown)),
                    icon: SizedBox.square(
                      dimension: 35,
                      child: Icon(Icons.upload_file_rounded),
                    ),
                    label: const Text(
                      'Upload Image',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ))
                : const SizedBox(
                    height: 30,
                  ),
            SizedBox(
              height: 30,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: multipleimage.length * 420, maxWidth: 300),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: multipleimage.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Image.file(
                          File(multipleimage[index].path),
                          height: 400,
                          width: 300,
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  })),
            )
          ],
        )),
      ),
    );
  }
}
