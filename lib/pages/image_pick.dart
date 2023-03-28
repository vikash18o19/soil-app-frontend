import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soil_app/utils/Colors.dart';
import 'package:soil_app/utils/location.dart';

String url = 'https://flask-ml-soil.azurewebsites.net/predict';

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
  var isFetch = 0;
  num lat = 0;
  num long = 0;
  bool loc_avail = false;

  Future<void> pickimagefromgallery() async {
    final imagepicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imagepicked != null) {
      setState(() {
        loc_avail = false;
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
        loc_avail = false;
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
    setState(() {
      isFetch = 1;
    });
    final List co_ordinates = await LocationServices.getLocation();
    print(List);
    setState(() {
      loc_avail = true;
      lat = co_ordinates[0];
      long = co_ordinates[1];
    });
    request.files.add(image);
    print("initiating request..");
    final response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        Status = 200;
        isFetch = 0;
      });
      return response.stream.bytesToString();
    } else {
      setState(() {
        isFetch = 0;
      });
      throw Exception('Failed to upload image');
    }
  }

  Future<void> save() async {
    var userId;
    var token;
    await SharedPreferences.getInstance().then((prefs) {
      userId = prefs.getString('userId');
      token = prefs.getString('token');
    });
    final url = Uri.parse(
        'https://6fda-2401-4900-3b32-135-f43d-eb5f-d9d8-89b6.in.ngrok.io/prediction/save'); // replace with your API URL

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token'
      },
      body: {
        'latitude': lat.toString(),
        'longitude': long.toString(),
        'prediction': prediction,
        'userId': userId,
      },
    );

    final message = json.decode(response.body)['message'];
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Message'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c2,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: isFetch == 0
              ? Column(
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
                    loc_avail == false
                        ? Text(prediction)
                        : Text('Prediction: ' +
                            '$prediction' +
                            ' location: ' +
                            '$lat' +
                            ' , ' +
                            '$long'),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton.icon(
                        onPressed: () => pickimagefromgallery(),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll(Size(220, 40)),
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.c4)),
                        icon: SizedBox.square(
                          dimension: 35,
                          child: Icon(Icons.image),
                        ),
                        label: const Text(
                          'Pick Image',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        onPressed: () => pickimagefromcamera(),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll(Size(220, 40)),
                            backgroundColor:
                                MaterialStatePropertyAll(AppColors.c4)),
                        icon: SizedBox.square(
                          dimension: 35,
                          child: Icon(
                            Icons.camera_alt_rounded,
                          ),
                        ),
                        label: const Text(
                          'Open Camera',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('error'),
                                    content: Text(error),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                            style: ButtonStyle(
                                minimumSize:
                                    MaterialStatePropertyAll(Size(220, 40)),
                                backgroundColor:
                                    MaterialStatePropertyAll(AppColors.c4)),
                            icon: SizedBox.square(
                              dimension: 35,
                              child: Icon(Icons.upload_file_rounded),
                            ),
                            label: const Text(
                              'Upload Image',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ))
                        : image != null
                            ? ElevatedButton.icon(
                                onPressed: () => {
                                      save().then((response) {
                                        // Handle the response from the server
                                      }).catchError((error) {
                                        print("error occured!!");
                                        // Handle any errors that occur
                                        print('Error: $error');
                                      })
                                    },
                                style: const ButtonStyle(
                                    minimumSize:
                                        MaterialStatePropertyAll(Size(220, 40)),
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.brown)),
                                icon: SizedBox.square(
                                  dimension: 35,
                                  child: Icon(Icons.save_rounded),
                                ),
                                label: const Text("Save Prediction"))
                            : SizedBox(
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
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 300,
                    ),
                    CircularProgressIndicator(color: Colors.brown[400]),
                  ],
                ),
        ),
      ),
    );
  }
}
