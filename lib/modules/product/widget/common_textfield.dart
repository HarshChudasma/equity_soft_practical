import 'package:equitysoft_practical/constants/colors_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String lableText;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final int? maximumLine;

  const CommonTextFieldWidget(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.lableText,
      this.textInputFormatter,
      this.textInputType,
      this.validator,
      this.maximumLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        focusColor: AppColorConstants.greyColor,
        isDense: true,
        labelText: lableText,
        labelStyle: const TextStyle(color: AppColorConstants.greyColor,fontSize: 16.0),
      ),
      cursorColor: AppColorConstants.greyColor,
      inputFormatters: textInputFormatter,
      keyboardType: textInputType,
      validator: validator,
      maxLines: maximumLine ?? 1,
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    );
  }
}
