import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Theming/colors.dart';
import '../Theming/text_style.dart';

class ProfilePhotoWidget extends StatefulWidget {
  final String? imagePath;
  final VoidCallback? onTap;
  const ProfilePhotoWidget({super.key, this.imagePath, this.onTap});

  @override
  _ProfilePhotoWidgetState createState() => _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState extends State<ProfilePhotoWidget> {
  File? image;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "تغيير صورة البروفايل",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              ListTile(
                leading:  Icon(Icons.camera_alt, color: ColorsApp.blue),
                title:  Text("الكاميرا", style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: ColorsApp.green),
                title:  Text("معرض الصور", style: Theme.of(context).textTheme.bodyLarge,),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child:  Text("إلغاء", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorsApp.darkRed)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: ColorsApp.grey500,
            backgroundImage: image != null
                ? FileImage(image!)
                : widget.imagePath != null
                ? AssetImage(widget.imagePath!) as ImageProvider
                : const AssetImage("assets/images/default_avatar.png"),
            child: image == null && widget.imagePath == null
                ? Icon(Icons.person, size: 60, color: ColorsApp.white)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: showImagePickerOptions,
              child: CircleAvatar(
                backgroundColor: ColorsApp.blue,
                radius: 20,
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}