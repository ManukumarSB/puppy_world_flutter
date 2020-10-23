import 'package:flutter/cupertino.dart';

import '../models/feed/models.dart';
import '../models/pets/models.dart';

class ResponseList<T> {
  List<T> items;
  int total;

  dynamic getObject(dynamic json) {
    switch (T) {
      case Pet:
        return Pet.fromJson(json);
      case PostModel:
        return PostModel.fromJson(json);
      case Comment:
        return Comment.fromJson(json);
      default:
        return json;
    }
  }

  ResponseList({@optionalTypeArgs this.items, @optionalTypeArgs this.total});
  ResponseList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<T>();
      json['items'].forEach((v) {
        items.add(getObject(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json["items"] = this.items;
    json["total"] = this.total;
    return json;
  }
}
