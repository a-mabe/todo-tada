/// Copyright (C) 2021 Abigail Mabe - All Rights Reserved
/// You may use, distribute and modify this code under the terms 
/// of the license.
///
/// You should have received a copy of the license with this file.
/// If not, please email <mabe.abby.a@gmail.com>
/// 
/// Defines the alert box for the settings page.
/// 

import 'package:flutter/material.dart';

class SettingsAlertDialog {

  /// The text for the cancel button.
  /// 
  /// e.g., 'Cancel'
  /// 
  String cancelButtonText = '';

  /// The text for the continue button.
  /// 
  /// e.g., 'Continue'
  /// 
  String continueButtonText = '';

  /// The title of the dialog box.
  /// 
  /// e.g., 'Alert'
  /// 
  String dialogTitle = '';

  /// The text content of the dialog box.
  /// 
  /// e.g., 'You are about to leave this page without saving changes.'
  /// 
  String dialogContent = '';

  /// Whether or not the user can tap outside the alert to
  /// dismiss it instead of tapping 'Cancel' or 'Continue'.
  /// Set to false and they can't, true they can.
  /// 
  /// Default is true.
  /// 
  /// e.g., true
  /// 
  bool barrierDismissable = true;

  /// Whether or not the user can use the Android back button
  /// to dismiss the dialog. Set to false and they can't, true 
  /// and they can.
  /// 
  /// Default is true.
  /// 
  /// e.g., true
  /// 
  bool androidBackWillPop = true;

  /// Whether to add a cancel button or just have a continue button.
  /// 
  /// e.g., true
  /// 
  bool addCancelButton = true;

  SettingsAlertDialog() {
    cancelButtonText = '';
    continueButtonText = '';
    dialogTitle = '';
    dialogContent = '';
    barrierDismissable = true;
  }

  SettingsAlertDialog.namedConst(String cancelButtonText,
                                 String continueButtonText,
                                 String dialogTitle,
                                 String dialogContent,
                                 bool barrierDismissable,
                                 bool androidBackWillPop,
                                 bool addCancelButton
  ) {
    this.cancelButtonText = cancelButtonText;
    this.continueButtonText = continueButtonText;
    this.dialogTitle = dialogTitle;
    this.dialogContent = dialogContent;
    this.barrierDismissable = barrierDismissable;
    this.androidBackWillPop = androidBackWillPop;
    this.addCancelButton = addCancelButton;
  }

  showAlertDialog(BuildContext context) {


    /// Set up the buttons.
    /// 
    Widget cancelButton = TextButton(
      child: Text(cancelButtonText,
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(continueButtonText,
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );


    /// Determine the number of buttons to display.
    /// 
    List<Widget> actions = [cancelButton, continueButton];
    if (addCancelButton)
      actions = [cancelButton, continueButton];
    else
      actions = [continueButton];


    /// Set up the dialog.
    /// 
    AlertDialog alert = AlertDialog(
      title: Text(dialogTitle,
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      content: Text(dialogContent,
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
      actions: actions,
    );


    /// Show the dialog.
    /// 
    showDialog(
      barrierDismissible: barrierDismissable,
      context: context,
      builder: (BuildContext context) {

        return new WillPopScope(
          onWillPop: () async => androidBackWillPop,
          child: alert
        );

      },
    );

  }
}