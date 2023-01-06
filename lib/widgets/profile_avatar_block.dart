import 'package:flutter/material.dart';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuchers_garage/providers/employee_provider.dart';
import 'package:wuchers_garage/utilities/auth.dart';

class ProfileAvatarBlock extends StatefulWidget {
  final EmployeeProvider employeeProvider;
  final String position;

  const ProfileAvatarBlock(
      {Key? key, required this.employeeProvider, required this.position})
      : super(key: key);

  @override
  State<ProfileAvatarBlock> createState() => _ProfileAvatarBlockState();
}

class _ProfileAvatarBlockState extends State<ProfileAvatarBlock> {
  final Authentication _authentication = Authentication();
  String _imagePath = '';

  MaterialButton bottomsheetButton(
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return MaterialButton(
      child: Card(
        elevation: 1.0,
        child: ListTile(
          leading: Icon(
            icon,
            size: 30.0,
          ),
          title: Text(label),
        ),
      ),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      color: Theme.of(context).primaryColorDark,
      width: double.infinity,
      height: size.height * 0.3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          //profile avatar
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 60.0,
              ),
              child: AvatarGlow(
                glowColor: Theme.of(context).primaryColor,
                endRadius: 70.0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  radius: size.width * 0.13,
                  foregroundImage: _authentication.getProfilePicture().isEmpty
                      ? const AssetImage('assets/images/unknown.png')
                      : FileImage(File(_authentication.getProfilePicture()))
                          as ImageProvider,
                ),
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 250.0,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          child: Text(
                            'Select New Avatar',
                            style: TextStyle(
                              fontSize: mediaQuery.textScaleFactor * 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        bottomsheetButton(
                          icon: Icons.photo,
                          label: 'Image from Gallery',
                          onPressed: _imageFromGallery,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        bottomsheetButton(
                          icon: Icons.add_a_photo,
                          label: 'Image from Camera',
                          onPressed: _imageFromCamera,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          //position
          Positioned(
            bottom: size.height * 0.065,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(
                  30.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: Text(
                  widget.position,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 10.0,
            child: SizedBox(
              width: size.width * 1,
              child: Text(
                widget.employeeProvider.getCurrentEmployee ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: mediaQuery.textScaleFactor * 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //retrieve image from gallery
  Future _imageFromGallery() async {
    late XFile _imageFile;
    XFile? image;
    late SharedPreferences saveImage;

    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    saveImage = await SharedPreferences.getInstance();

    if (image != null) {
      setState(() {
        _imageFile = image as XFile;
        Navigator.of(context).pop();
      });
    }

    saveImage.setString("imgPath", _imageFile.path);

    setState(() {
      _imagePath = saveImage.getString("imgPath") as String;
      _authentication.updateProfilePicture(_imagePath);
    });
  }

  // retrieve image from camera
  Future _imageFromCamera() async {
    late XFile _imageFile;
    XFile? image;
    late SharedPreferences saveImage;

    image = await ImagePicker().pickImage(source: ImageSource.camera);
    saveImage = await SharedPreferences.getInstance();

    if (image != null) {
      setState(() {
        _imageFile = image as XFile;
        Navigator.of(context).pop();
      });
    }

    saveImage.setString("imgPath", _imageFile.path);

    setState(() {
      _imagePath = saveImage.getString("imgPath") as String;
      _authentication.updateProfilePicture(_imagePath);
    });
  }
}
