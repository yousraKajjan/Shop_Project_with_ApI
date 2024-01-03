class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  HomeDataModel.fromJson(json['data']) : null;
  }

}

class HomeDataModel {
  List<BannersModel>? banners=[];
  List<ProductsModel>? products=[];

  HomeDataModel({this.banners, this.products});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach((v) {
        banners!.add(BannersModel.fromJson(v));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((v) {
        products!.add(ProductsModel.fromJson(v));
      });
    }
  }

}

class BannersModel {
  int? id;
  String? image;

  BannersModel({this.id, this.image});

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }


}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductsModel(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.inFavorites,
        this.inCart});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
