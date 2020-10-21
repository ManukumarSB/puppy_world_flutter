import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class ClearableTextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int index;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function validator;
  final Function valueCallback;
  final Function hideOptInCallback;
  final TextCapitalization textCapitalization;
  final String prefixText;
  final FocusNode focusNode;
  final bool enabled;
  final Function onChanged;
  final Function onFieldSubmitted;
  final String errorText;
  final TextInputAction textInputAction;
  final Color errorTextColor;

  ClearableTextFormFieldWidget({
    @required this.controller,
    @required this.labelText,
    this.hintText = '',
    this.valueCallback,
    this.hideOptInCallback,
    this.index,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.prefixText,
    this.focusNode,
    this.enabled = true,
    this.onChanged,
    this.onFieldSubmitted,
    this.errorText,
    this.textInputAction = TextInputAction.next,
    this.errorTextColor,
  });

  @override
  State<StatefulWidget> createState() => _ClearableTextFormFieldWidgetState();
}

class _ClearableTextFormFieldWidgetState
    extends State<ClearableTextFormFieldWidget> {
  bool _showClearIcon = false;
  bool _isPasswordField;

  @override
  void initState() {
    super.initState();
    _isPasswordField = widget.obscureText;
    _showClearIcon = widget.controller.text.isNotEmpty;
    widget.controller.addListener(() {
      this.setState(
          () => this._showClearIcon = widget.controller.text.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        autocorrect: false,
        obscureText: _isPasswordField,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          fillColor: Theme.of(context).canvasColor,
          filled: true,
          alignLabelWithHint: true,
          errorMaxLines: 3,
          errorStyle: TextStyle(
            color: widget.errorTextColor,
            fontWeight: FontWeight.normal,
            fontSize: 13,
          ),
          labelText: widget.labelText,
          // hintText: widget.hintText,
          prefixText: widget.prefixText,
          errorText: widget.errorText,
          suffixStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          suffixIcon: _showSuffixIcon(),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.errorTextColor ?? Theme.of(context).errorColor,
              width: 2,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: widget.errorTextColor ?? Theme.of(context).errorColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).inputDecorationTheme.labelStyle.color,
              width: 1,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).inputDecorationTheme.labelStyle.color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _showSuffixIcon() {
    if (widget.obscureText) return _showPasswordSuffixIcon();
    return this._showClearIcon
        ? IconButton(
            color: Theme.of(context).hintColor,
            icon: Icon(
              Icons.highlight_off,
              size: 18,
            ),
            onPressed: () {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                widget.controller.clear();
                if (widget.index != null && widget.valueCallback != null)
                  widget.valueCallback('', widget.index);
                if (widget.labelText == 'MOBILE NUMBER' &&
                    widget.hideOptInCallback != null)
                  widget.hideOptInCallback(true);
              });
            },
          )
        : null;
  }

  Widget _showPasswordSuffixIcon() {
    return Container(
      width: 64,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          child: Icon(
            _isPasswordField ? Icons.visibility : Icons.visibility_off,
            size: 18,
            color: Theme.of(context).hintColor,
          ),
          onPressed: () {
            setState(() => _isPasswordField = !_isPasswordField);
          }),
    );
  }
}
