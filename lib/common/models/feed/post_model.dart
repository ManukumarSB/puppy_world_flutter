import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class PostModel {
  static const String dateTimeFormatString = "yyyyMMdd'T'HHmmss";
  String id;
  String userId;
  String postUrl;
  String postType;
  String title;
  DateTime createdTime;
  DateTime lastModified;
  bool isPrivate;
  List<String> hashTags;
  List<String> likes;
  List<Comment> comments;
  int rank;
  int viewsCount;

  PostModel(
      {@optionalTypeArgs this.id,
      @optionalTypeArgs this.userId,
      @optionalTypeArgs this.title,
      @optionalTypeArgs this.postUrl,
      @optionalTypeArgs this.postType,
      @optionalTypeArgs this.createdTime,
      @optionalTypeArgs this.lastModified,
      @optionalTypeArgs this.isPrivate,
      @optionalTypeArgs this.hashTags,
      @optionalTypeArgs this.likes,
      @optionalTypeArgs this.comments,
      @optionalTypeArgs this.rank,
      @optionalTypeArgs this.viewsCount});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    postUrl = json['postUrl'];
    postType = json['postType'];
    createdTime = json['createdTime'] != null
        ? DateTime.parse(json['createdTime'])
        : null;
    lastModified = json['lastModified'] != null
        ? DateTime.parse(json['lastModified'])
        : null;
    isPrivate = json['isPrivate'];
    hashTags = json['hashTags'].cast<String>();
    likes = json['likes'].cast<String>();
    if (json['comments'] != null) {
      comments = new List<Comment>();
      json['comments'].forEach((v) {
        comments.add(new Comment.fromJson(v));
      });
    }
    rank = json['rank'];
    viewsCount = json['viewsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['postUrl'] = this.postUrl;
    data['postType'] = this.postType;
    data['createdTime'] = this.createdTime != null
        ? DateFormat(PostModel.dateTimeFormatString).format(this.createdTime)
        : null;
    data['lastModified'] = this.lastModified != null
        ? DateFormat(PostModel.dateTimeFormatString).format(this.lastModified)
        : null;
    data['isPrivate'] = this.isPrivate;
    data['hashTags'] = this.hashTags;
    data['likes'] = this.likes;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['rank'] = this.rank;
    data['viewsCount'] = this.viewsCount;
    return data;
  }
}

class Comment {
  String userId;
  String comment;
  List<Comment> replies;
  List<String> likes;
  DateTime createdTime;
  DateTime lastModified;

  Comment(
      {@optionalTypeArgs this.userId,
      @optionalTypeArgs this.comment,
      @optionalTypeArgs this.replies,
      @optionalTypeArgs this.likes,
      @optionalTypeArgs this.createdTime,
      @optionalTypeArgs this.lastModified});

  Comment.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    comment = json['comment'];
    if (json['replies'] != null) {
      replies = new List<Comment>();
      json['replies'].forEach((v) {
        replies.add(new Comment.fromJson(v));
      });
    }
    likes = json['likes'].cast<String>();
    createdTime = json['createdTime'] != null
        ? DateTime.parse(json['createdTime'])
        : null;
    lastModified = json['lastModified'] != null
        ? DateTime.parse(json['lastModified'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['comment'] = this.comment;
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    data['likes'] = this.likes;
    data['createdTime'] = this.createdTime != null
        ? DateFormat(PostModel.dateTimeFormatString).format(this.createdTime)
        : null;
    data['lastModified'] = this.lastModified != null
        ? DateFormat(PostModel.dateTimeFormatString).format(this.lastModified)
        : null;
    return data;
  }
}
