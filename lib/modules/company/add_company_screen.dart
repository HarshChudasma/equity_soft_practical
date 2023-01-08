import 'package:equitysoft_practical/modules/product/widget/common_textfield.dart';
import 'package:flutter/material.dart';

import '../../constants/colors_constant.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _companyTextEditingController = TextEditingController();

  final FocusNode _companyFocusNode = FocusNode();

  @override
  void initState() {
    setTextFieldFocusNode();
    super.initState();
  }

  void setTextFieldFocusNode() {
    _companyFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColorConstants.greyColor,
        title: const Text(
          "Company",
          style: TextStyle(
            fontSize: 24.0,
            color: AppColorConstants.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                CommonTextFieldWidget(
                  controller: _companyTextEditingController,
                  focusNode: _companyFocusNode,
                  lableText: "Company Name",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorConstants.greyColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: AppColorConstants.whiteColor, fontSize: 14.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  "List of companies",
                  style: TextStyle(
                      color: AppColorConstants.greyColor, fontSize: 14.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return _listofCompany();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listofCompany(){
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColorConstants.greyColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: const [
          Expanded(
            child: Text(
              "Category Name",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColorConstants.whiteColor,
                fontSize: 18.0,
              ),
            ),
          ),
          InkWell(
            child: Icon(
              Icons.delete_outline_outlined,
              color: AppColorConstants.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _companyTextEditingController.dispose();
    _companyFocusNode.dispose();
    super.dispose();
  }


}