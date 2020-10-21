import 'package:flutter/cupertino.dart';

class UserAccount {
  String id;
  String name;
  String role;
  String email;
  UserDetails userDetails;
  AccountDetails accountDetails;

  UserAccount(
      {@optionalTypeArgs this.id,
      @optionalTypeArgs this.name,
      @optionalTypeArgs this.role,
      @optionalTypeArgs this.email,
      @optionalTypeArgs this.userDetails,
      @optionalTypeArgs this.accountDetails});

  UserAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    email = json['email'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    accountDetails = json['accountDetails'] != null
        ? new AccountDetails.fromJson(json['accountDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['role'] = this.role;
    data['email'] = this.email;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails.toJson();
    }
    if (this.accountDetails != null) {
      data['accountDetails'] = this.accountDetails.toJson();
    }
    return data;
  }
}

class UserDetails {
  String profileImage;
  String gender;
  String dob;
  String bio;
  Mobile mobile;
  Location location;

  UserDetails(
      {@optionalTypeArgs this.profileImage,
      @optionalTypeArgs this.gender,
      @optionalTypeArgs this.dob,
      @optionalTypeArgs this.bio,
      @optionalTypeArgs this.mobile,
      @optionalTypeArgs this.location});

  UserDetails.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    gender = json['gender'];
    dob = json['dob'];
    bio = json['bio'];
    mobile =
        json['mobile'] != null ? new Mobile.fromJson(json['mobile']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileImage'] = this.profileImage;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['bio'] = this.bio;
    if (this.mobile != null) {
      data['mobile'] = this.mobile.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}

class Mobile {
  String code;
  String number;

  Mobile({@optionalTypeArgs this.code, @optionalTypeArgs this.number});

  Mobile.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['number'] = this.number;
    return data;
  }
}

class Location {
  String home;
  String city;
  String state;
  String country;
  String zip;
  GeoCoordinate geoCoordinate;

  Location(
      {@optionalTypeArgs this.home,
      @optionalTypeArgs this.city,
      @optionalTypeArgs this.state,
      @optionalTypeArgs this.country,
      @optionalTypeArgs this.zip,
      @optionalTypeArgs this.geoCoordinate});

  Location.fromJson(Map<String, dynamic> json) {
    home = json['home'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    geoCoordinate = json['geoCoordinate'] != null
        ? new GeoCoordinate.fromJson(json['geoCoordinate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['home'] = this.home;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip'] = this.zip;
    if (this.geoCoordinate != null) {
      data['geoCoordinate'] = this.geoCoordinate.toJson();
    }
    return data;
  }
}

class GeoCoordinate {
  double lat;
  double long;

  GeoCoordinate({@optionalTypeArgs this.lat, @optionalTypeArgs this.long});

  GeoCoordinate.fromJson(Map<String, dynamic> json) {
    lat = (json['lat'] as num)?.toDouble();
    long = (json['long'] as num)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}

class AccountDetails {
  List<String> followers;
  List<String> following;
  List<String> blackList;
  bool isMobileVerified;
  bool isEmailVerified;
  bool isNewsLetter;
  bool isSuspended;
  bool isMarkedForDeletion;

  AccountDetails(
      {this.followers,
      this.following,
      this.blackList,
      this.isMobileVerified,
      this.isEmailVerified,
      this.isNewsLetter,
      this.isSuspended,
      this.isMarkedForDeletion});

  AccountDetails.fromJson(Map<String, dynamic> json) {
    followers = json['followers'].cast<String>();
    following = json['following'].cast<String>();
    blackList = json['blackList'].cast<String>();
    isMobileVerified = json['isMobileVerified'];
    isEmailVerified = json['isEmailVerified'];
    isNewsLetter = json['isNewsLetter'];
    isSuspended = json['isSuspended'];
    isMarkedForDeletion = json['isMarkedForDeletion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['blackList'] = this.blackList;
    data['isMobileVerified'] = this.isMobileVerified;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isNewsLetter'] = this.isNewsLetter;
    data['isSuspended'] = this.isSuspended;
    data['isMarkedForDeletion'] = this.isMarkedForDeletion;
    return data;
  }
}
