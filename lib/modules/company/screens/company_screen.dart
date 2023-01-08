import 'package:equitysoft_practical/database/company_tbl.dart';
import 'package:equitysoft_practical/modules/company/controllers/company_controller.dart';
import 'package:equitysoft_practical/modules/company/models/company_model.dart';
import 'package:equitysoft_practical/modules/product/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors_constant.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _companyTextEditingController =
      TextEditingController();
  CompanyController companyController = Get.find<CompanyController>();


  final FocusNode _companyFocusNode = FocusNode();

  List<CompanyModel> _companyModelList = [];

  @override
  void initState() {
    setTextFieldFocusNode();
    companyController.getCompanyDb();
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Company!";
                    }
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      CompanyModel companyModel = CompanyModel(companyName: _companyTextEditingController.text);
                      companyController.addCompanytoDb(companyModel);
                      _companyTextEditingController.text = "";
                      FocusScope.of(context).unfocus();
                    }
                  },
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
                Obx(() => Expanded(
                  child: companyController.isLoading.value ? Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: AppColorConstants.greyColor,
                    ),
                  ) : companyController.companyList.isEmpty
                      ? Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "No Data Found!",
                      style: TextStyle(
                          color: AppColorConstants.greyColor,
                          fontSize: 24.0),
                    ),
                  )
                      : ListView.builder(
                    itemCount: companyController.companyList.length,
                    itemBuilder: (context, index) {
                      return _listofCompany(index);
                    },
                  ),
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listofCompany(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColorConstants.greyColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              companyController.companyList[index].companyName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColorConstants.whiteColor,
                fontSize: 18.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              companyController.deleteCompanyFromDb(companyController.companyList[index].id, index);
            },
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
