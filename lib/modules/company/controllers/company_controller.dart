import 'package:equitysoft_practical/database/company_tbl.dart';
import 'package:equitysoft_practical/modules/company/models/company_model.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController{
  final RxList<CompanyModel> companyList = RxList<CompanyModel>([]);
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  final RxBool isAddLoad = true.obs;
  final RxBool isAddError = false.obs;
  CompanyModel? companyModel;

  getCompanyDb() {
    isLoading.value = true;
    try{
      CompanyTable.getAllCompanyFromDb().then(
            (value) {
              companyList.value = value;
          isLoading.value = false;
        },
      );
    } catch(error){
      isError.value = true;
      isLoading.value = false;
    }
  }

  addCompanytoDb(CompanyModel companyModel){
    isAddLoad.value = true;
    try{
      CompanyTable.addNewCompany(companyModel: companyModel).then((value) {
        isAddLoad.value = false;
        getCompanyDb();
      });

    } catch(error){
      isAddError.value = true;
      isAddLoad.value = false;
    }
  }

  deleteCompanyFromDb(int companyId,int index){
    CompanyTable.deleteCompanyByCompanyId(companyId: companyId).then((value) {
      companyList.remove(index);
      getCompanyDb();
    });
  }
}