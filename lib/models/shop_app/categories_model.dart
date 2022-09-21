class CategoriesModel{
  bool status;
  CategoriesDataModel dataModel;
  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    dataModel = CategoriesDataModel.fromJson(json['data']);
  }
}
class CategoriesDataModel{
  int currentPage;
  List<dataModel> data=[];
  CategoriesDataModel.fromJson(Map<String,dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(dataModel.fromJson(element));
    });
  }
}
class dataModel{
  int id;
  String name;
  String image;
  dataModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
