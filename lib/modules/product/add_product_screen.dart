import 'dart:io';

import 'package:equitysoft_practical/modules/product/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors_constant.dart';
import '../../utils/permission_utils.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();

  final FocusNode _productNameFocusNode = FocusNode();
  final FocusNode _categoryFocusNode = FocusNode();
  final FocusNode _companyFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _qtyFocusNode = FocusNode();

  final picker = ImagePicker();
  late File image;

  @override
  void initState() {
    setTextFieldFocusNode();
    super.initState();
  }

  void setTextFieldFocusNode() {
    _productNameFocusNode.addListener(() {
      setState(() {});
    });
    _categoryFocusNode.addListener(() {
      setState(() {});
    });
    _companyFocusNode.addListener(() {
      setState(() {});
    });
    _descriptionFocusNode.addListener(() {
      setState(() {});
    });
    _priceFocusNode.addListener(() {
      setState(() {});
    });
    _qtyFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColorConstants.greyColor,
        title: const Text(
          "Add Products",
          style: TextStyle(
            fontSize: 24.0,
            color: AppColorConstants.whiteColor,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 12.0,
                  ),
                  CommonTextFieldWidget(
                    controller: _productNameController,
                    focusNode: _productNameFocusNode,
                    lableText: "Product Name",
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CommonTextFieldWidget(
                    controller: _descriptionController,
                    focusNode: _descriptionFocusNode,
                    lableText: "Description",
                    textInputType: TextInputType.multiline,
                    maximumLine: 5,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CommonTextFieldWidget(
                    controller: _priceController,
                    focusNode: _priceFocusNode,
                    lableText: "Price",
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CommonTextFieldWidget(
                    controller: _qtyController,
                    focusNode: _qtyFocusNode,
                    lableText: "Qty",
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upload Image:",
                      style: TextStyle(
                          fontSize: 14.0, color: AppColorConstants.greyColor),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            _selectImageFromGallary(platform);
                          },
                          child: Container(
                            height: 42.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColorConstants.greyColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 42.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColorConstants.greyColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 42.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColorConstants.greyColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 42.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColorConstants.greyColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Minimum 2 Image",
                      style: TextStyle(
                          fontSize: 14.0, color: AppColorConstants.greyColor),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorConstants.greyColor,
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: AppColorConstants.whiteColor, fontSize: 14.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectImageFromGallary(TargetPlatform platform) async {
    PermissionUtil.checkPermission(platform)
        .then((isGranted) async {
      if (isGranted != null && isGranted) {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        image = File(pickedFile!.path);
        print("selected image file from the gallery : ${image}");
      } else {
        print('perimssion nont granted...........');
      }
    });
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _categoryController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _qtyController.dispose();
    _productNameFocusNode.dispose();
    _categoryFocusNode.dispose();
    _companyFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _qtyFocusNode.dispose();
    super.dispose();
  }
}
