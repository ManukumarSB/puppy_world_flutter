import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../common/models/user/user.dart';
import '../../common/models/user/user_details.dart';
import '../../common/widgets/primary_button_widget.dart';
import '../../common/models/user/location.dart';
import '../../user_auth/providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/auth-signUp';

  final String email;
  SignUpScreen({this.email});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File sampleImage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _confirmPassController = TextEditingController();

  Future getImage(var imageSource) async {
    var tempImage = await ImagePicker.pickImage(
      source: imageSource,
      maxHeight: 400,
      maxWidth: 400,
    );

    setState(() {
      sampleImage = tempImage;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  void dispose() {
    _passController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _fullNameController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _buildImagePickerDialog();
                  },
                  child: _buildAddPhoto(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildDivider(),
                    _buildTextField('Full Name', _fullNameController),
                    _buildDivider(),
                    _buildTextField('Phone', _phoneController),
                    _buildDivider(),
                    _buildTextField('Email', _emailController),
                    _buildDivider(),
                    _buildTextField('Password', _passController),
                    _buildDivider(),
                    _buildTextField(
                        'Re-enter password', _confirmPassController),
                    _buildDivider(),
                    _buildDivider(),
                    PrimaryButtonWidget(false, 'Continue', () async {
                      final authProvider =
                          Provider.of<AuthProvider>(context, listen: false);
                      User user = User(
                        null,
                        _fullNameController.text,
                        null,
                        _emailController.text,
                        UserDetails(
                          null,
                          null,
                          null,
                          null,
                          Mobile(null, _phoneController.text),
                          Location(null, null, null, null, null, null),
                        ),
                        null,
                      );
                      authProvider.createUser(
                        user: user,
                        password: _passController.text,
                        profilePicture: sampleImage,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _buildImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.camera_alt),
                  iconSize: 40.0,
                  onPressed: () async {
                    await getImage(ImageSource.camera);
                    Navigator.pop(context);
                  }),
              IconButton(
                  icon: Icon(Icons.image),
                  iconSize: 40.0,
                  onPressed: () {
                    getImage(ImageSource.gallery);

                    Navigator.pop(context);
                  })
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        'Sign-Up to Continue',
        style: Theme.of(context).textTheme.headline6.copyWith(
            fontWeight: FontWeight.w600, color: Theme.of(context).canvasColor),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildAddPhoto() {
    return Container(
      width: 100.0,
      height: 100.0,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        image: sampleImage != null
            ? DecorationImage(
                image: Image.file(
                  sampleImage,
                ).image,
                fit: BoxFit.fill,
              )
            : null,
      ),
      child: sampleImage == null
          ? Text(
              "Add photo",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            )
          : Container(),
    );
  }

  Widget _buildDivider() {
    return const SizedBox(height: 16);
  }

  Widget _buildTextField(
      String hintText, TextEditingController fullNameController) {
    return TextField(
      controller: fullNameController,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
