import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final bool isLoading;
  final Function onButtonClick;
  final String buttonText;
  PrimaryButtonWidget(this.isLoading, this.buttonText, this.onButtonClick);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ButtonTheme.fromButtonThemeData(
        data: Theme.of(context).buttonTheme.copyWith(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
        child: RaisedButton(
          child: isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Theme.of(context).textTheme.button.color,
                )
              : Text(
                  buttonText,
                  style:
                      Theme.of(context).textTheme.button.copyWith(fontSize: 18),
                ),
          onPressed: isLoading ? () {} : onButtonClick,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
