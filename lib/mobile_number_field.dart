library mobile_number_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const flagWidth = 24.0;

class MobileInputValueNotifier extends ValueNotifier<String> {
  MobileInputValueNotifier() : super("");
}

class MobileInputLayout extends StatefulWidget {
  final String flagImg;
  final String countryCode;
  final String hintText;
  final int maxLength;
  final Color colorBaselineNormal;
  final TextEditingController textEditingController;
  final MobileInputValueNotifier mobileInputValueNotifier;

  const MobileInputLayout(
      {this.maxLength,
        this.colorBaselineNormal,
        this.textEditingController,
        this.mobileInputValueNotifier,
        this.countryCode,
        this.flagImg,
        this.hintText});

  @override
  _MobileInputLayoutState createState() => _MobileInputLayoutState();
}

class _MobileInputLayoutState extends State<MobileInputLayout> {
  String errorMessage;

  @override
  void initState() {
    super.initState();

    widget.mobileInputValueNotifier.addListener(() {
      setState(() {
        errorMessage = widget.mobileInputValueNotifier.value;
      });
    });
  }

  @override
  void dispose() {
    widget.mobileInputValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.flagImg,
            width: flagWidth,
            fit: BoxFit.cover,
          ),
          Text(
            widget.countryCode,
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: widget.textEditingController,
                inputFormatters: <TextInputFormatter>[
                  // ignore: deprecated_member_use
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                maxLength: widget.maxLength,
                decoration: InputDecoration(
                  errorText: errorMessage,
                  hintText: widget.hintText,
                  counterText: "",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.colorBaselineNormal),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.colorBaselineNormal),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.colorBaselineNormal),
                  ),
                ),
                onChanged: (newValue) {
                  if (newValue.isNotEmpty) {
                    widget.mobileInputValueNotifier.value = null;
                  }
                },
              ),
              margin: EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }
}
