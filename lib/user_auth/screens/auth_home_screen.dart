import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../user_auth/screens/screens.dart';
import '../../common/widgets/clearable_text_form_field_widget.dart';
import '../../common/widgets/primary_button_widget.dart';
import '../../common/helpers/validators.dart';
import '../../user_auth/providers/auth_provider.dart';

class AuthHomeScreen extends StatefulWidget {
  static const routeName = 'user-auth/home';

  AuthHomeScreen({Key key}) : super(key: key);

  @override
  _AuthHomeScreenState createState() => _AuthHomeScreenState();
}

class _AuthHomeScreenState extends State<AuthHomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailAddressController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailAddressFocusNode = FocusNode();
  String _passwordErrorText, _emailAddressErrorText;
  bool _errorIsActuallyInfo = false;
  bool _loginInProgress = false;
  bool _isVerifyNewEmail = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailAddressController.dispose();
    _emailAddressFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildLoginForm(),
                          _buildPrimaryButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PrimaryButtonWidget(
        _loginInProgress,
        'Next',
        (Validators.isValidEmail(_emailAddressController.text) &&
                (_emailAddressErrorText == null ||
                    _passwordController.text.length > 0))
            ? _submitEmailAddress
            : null,
      ),
    );
  }

  void _submitEmailAddress() {
    if (!_isVerifyNewEmail) {
      if (_emailAddressErrorText != null) {
        _doLogin();
      } else {
        _verifyEmail();
      }
    }
  }

  void _verifyEmail() async {
    try {
      _isVerifyNewEmail = false;
      _errorIsActuallyInfo = false;

      if (_loginInProgress || !_formKey.currentState.validate()) {
        return;
      }
      setState(() {
        _emailAddressErrorText = null;
        _loginInProgress = true;
      });
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.verifyEmail(_emailAddressController.text.trim());
      if (authProvider.verifyNewSupporterEmail) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SignUpScreen(email: _emailAddressController.text),
          ),
        );
      } else {
        _setEmailAddressError('Please provide password to continue');
      }
    } finally {
      setState(() {
        _loginInProgress = false;
      });
    }
  }

  void _doLogin() async {
    try {
      if (_loginInProgress || !_formKey.currentState.validate()) {
        return;
      }
      setState(() {
        _passwordErrorText = null;
        _loginInProgress = true;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = await authProvider.login(
        _emailAddressController.text.trim(),
        _passwordController.text,
      );

      // widget.onLoginComplete(user);
    } finally {
      setState(() {
        _loginInProgress = false;
      });
    }
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        'Enter Email to Continue',
        style: Theme.of(context).textTheme.headline6.copyWith(
            fontWeight: FontWeight.w600, color: Theme.of(context).canvasColor),
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

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
      child: Form(
        key: _formKey,
        child: Consumer(
          builder: (_, AuthProvider authProvider, Widget child) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: _emailAddressErrorText != null ? 110 : null,
                  child: ClearableTextFormFieldWidget(
                    controller: _emailAddressController,
                    labelText: 'EMAIL',
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    errorText: _emailAddressErrorText,
                    errorTextColor: _errorIsActuallyInfo
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).errorColor,
                    onChanged: (val) {
                      _emailAddressErrorText = null;
                      _isVerifyNewEmail = false;
                      _errorIsActuallyInfo = false;
                      if (_passwordController.text.length > 0)
                        _passwordController.clear();
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                    focusNode: _emailAddressFocusNode,
                  ),
                ),
                const SizedBox(height: 16),
                _emailAddressErrorText != null
                    ? ClearableTextFormFieldWidget(
                        controller: _passwordController,
                        labelText: 'PASSWORD',
                        obscureText: true,
                        errorText: _passwordErrorText,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'required';
                          } else if (!Validators.validatePassword(
                              _passwordController.text)) {
                            return 'Please enter strong password which contain capital and special characters.';
                          }
                          return null;
                        },
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                      )
                    : Container(),
                _buildCantLoginButton(context)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCantLoginButton(BuildContext context) {
    if (_emailAddressErrorText == null) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              'Trouble logging in?',
              style: Theme.of(context).textTheme.button.copyWith(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          onTap: () {
            // Navigator.of(context).pushNamed(ForgetPasswordScreen.routeName);
          },
        ),
      ],
    );
  }

  void _setEmailAddressError(String errorMessage) {
    setState(() {
      _emailAddressErrorText = errorMessage;
      _emailAddressFocusNode.requestFocus();
    });
  }

  void _setPasswordError(String errorMessage) {
    setState(() {
      _passwordErrorText = errorMessage;
      _passwordFocusNode.requestFocus();
    });
  }
}
