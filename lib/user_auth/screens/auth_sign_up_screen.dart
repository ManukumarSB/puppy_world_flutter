import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../account/screens/account_screen.dart';
import '../../common/exceptions/custom_exceptions.dart';
import '../../common/helpers/validators.dart';
import '../../common/widgets/clearable_text_form_field_widget.dart';
import '../../common/widgets/primary_button_widget.dart';
import '../../common/models/user/user_account.dart';
import '../../user_auth/providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/auth-signUp';
  final VoidCallback onBack;
  final String email;
  SignUpScreen({this.email, this.onBack});
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File sampleImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _confirmPassController = TextEditingController();
  bool _signUpProgress = false;
  String _mobileErrorText, _emailErrorText;

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
          child: Form(
            key: _formKey,
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
                      _buildFullNameForm(),
                      _buildPhoneForm(),
                      _buildEmailForm(),
                      _buildPasswordForm(),
                      _buildConfirmPasswordForm(),
                      _buildDivider(),
                      PrimaryButtonWidget(
                          _signUpProgress, 'Continue', _onClickContinue)
                    ],
                  ),
                ],
              ),
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
        'Create your account',
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

  bool _confirmPassword() {
    if (_confirmPassController.text?.isEmpty ?? true) return false;
    return _confirmPassController.text == _passController.text;
  }

  _onClickContinue() async {
    try {
      if (_signUpProgress || !_formKey.currentState.validate()) {
        return;
      }
      _confirmPassword();

      setState(() {
        _signUpProgress = true;
        _mobileErrorText = null;
        _emailErrorText = null;
      });
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      UserAccount user = UserAccount(
          name: _fullNameController.text,
          userDetails:
              UserDetails(mobile: Mobile(number: _phoneController.text)),
          email: _emailController.text);
      await authProvider.createUser(
        user: user,
        password: _passController.text,
        profilePicture: sampleImage,
      );
      Navigator.pushNamedAndRemoveUntil(
          context, AccountScreen.routeName, (route) => false);
    } on DuplicateMobileException {
      _setMobileException('Mobile number already exist');
    } on DuplicateEmailException {
      _setEmailException('Email already exist');
    } finally {
      setState(() {
        _signUpProgress = false;
      });
    }
  }

  Widget _buildFullNameForm() {
    return ListTile(
      leading: Container(
        height: double.infinity,
        child: const Icon(Icons.person),
      ),
      title: ClearableTextFormFieldWidget(
        controller: _fullNameController,
        labelText: 'Name',
        keyboardType: TextInputType.phone,
        validator: (name) => Validators.validateName(name),
      ),
    );
  }

  Widget _buildPhoneForm() {
    return ListTile(
      leading: Container(
        height: double.infinity,
        child: const Icon(Icons.phone),
      ),
      title: ClearableTextFormFieldWidget(
        controller: _phoneController,
        labelText: 'Mobile',
        textCapitalization: TextCapitalization.words,
        errorText: _mobileErrorText,
        validator: (String value) {
          if (value.isEmpty) {
            return 'required';
          } else if (value.length < 10) {
            return 'invalid phone number';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailForm() {
    return ListTile(
      leading: Container(
        height: double.infinity,
        child: const Icon(Icons.email),
      ),
      title: ClearableTextFormFieldWidget(
        controller: _emailController,
        labelText: 'Email',
        errorText: _emailErrorText,
        keyboardType: TextInputType.emailAddress,
        validator: (email) => Validators.validateEmail(email),
      ),
    );
  }

  Widget _buildPasswordForm() {
    return ListTile(
      leading: Container(
        height: double.infinity,
        child: const Icon(Icons.security),
      ),
      title: ClearableTextFormFieldWidget(
        controller: _passController,
        labelText: 'Password',
        obscureText: true,
        validator: (password) => Validators.validatePassword(password),
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _buildConfirmPasswordForm() {
    return ListTile(
      leading: Container(
        height: double.infinity,
        child: const Icon(null),
      ),
      title: ClearableTextFormFieldWidget(
        controller: _confirmPassController,
        labelText: 'Re-enter password',
        obscureText: true,
        validator: (value) {
          if (!_confirmPassword()) {
            return 'Password mismatch';
          }
          return null;
        },
        textInputAction: TextInputAction.done,
      ),
    );
  }

  void _setMobileException(String errorMessage) {
    setState(() {
      _mobileErrorText = errorMessage;
    });
  }

  void _setEmailException(String errorMessage) {
    setState(() {
      _emailErrorText = errorMessage;
    });
  }
}
