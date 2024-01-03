class ChangeFavoritModle {
  bool? status;
  String? message;
  ChangeFavoritModle.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
