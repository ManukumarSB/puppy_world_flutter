import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class HeaderBuilder {
  Map<String, String> _headers = Map<String, String>();
  Map<String, String> build() => _headers;

  HeaderBuilder setToJsonType() {
    _headers["Content-Type"] = "application/json";
    return this;
  }

  HeaderBuilder add(String key, String value) {
    if (!(key?.isEmpty ?? true)) {
      _headers[key] = value;
    }
    return this;
  }
}

class FormDataBuilder {
  Map<String, dynamic> _requestData = Map<String, dynamic>();

  FormData build() => FormData.fromMap(_requestData);

  Future<FormDataBuilder> addFile(String key, File file,
      {@optionalTypeArgs String fileName}) async {
    if (file == null || (key?.isEmpty ?? true)) return this;
    if (fileName?.isEmpty ?? true)
      fileName = "file" + file.path.substring(file.path.lastIndexOf("."));
    _requestData[key] =
        await MultipartFile.fromFile(file.path, filename: fileName);
    return this;
  }

  FormDataBuilder addText(String key, Object value,
      {@optionalTypeArgs String fileName}) {
    if ((key?.isEmpty ?? true)) return this;
    _requestData[key] = jsonEncode(value);
    return this;
  }
}
