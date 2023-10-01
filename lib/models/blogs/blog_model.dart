// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class BlogModel {
  final int? id;
  final int? user;
  final String? title;
  final String? content;
  final String? images;
  final List<dynamic>? views;
  final List<dynamic>? likes;
  final String? updated;
  final String? created;
  const BlogModel({
    this.id,
    this.user,
    this.title,
    this.content,
    this.images,
    this.views,
    this.likes,
    this.updated,
    this.created,
  });

  BlogModel copyWith({
    int? id,
    int? user,
    String? title,
    String? content,
    String? images,
    List<dynamic>? views,
    List<dynamic>? likes,
    String? updated,
    String? created,
  }) {
    return BlogModel(
      id: id ?? this.id,
      user: user ?? this.user,
      title: title ?? this.title,
      content: content ?? this.content,
      images: images ?? this.images,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      updated: updated ?? this.updated,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toJSON() => {
        'id': id,
        'user': user,
        'title': title,
        'content': content,
        'images': images,
        'views': views,
        'likes': likes,
        'updated': updated,
        'created': created,
      };

  factory BlogModel.fromJSON(Map<String, dynamic> json) => BlogModel(
        id: json['id'] ?? 0,
        user: json['user'] ?? 0,
        title: json['title'] ?? '',
        content: json['content'] ?? '',
        images: json['images'] ?? '',
        views: json['views'] ?? [],
        likes: json['likes'] ?? [],
        updated: json['updated'] ?? '',
        created: json['created'] ?? '',
      );

  @override
  String toString() {
    return 'BlogModel(id: $id, user: $user, title: $title, content: $content, images: $images, views: $views, likes: $likes, updated: $updated, created: $created)';
  }

  @override
  bool operator ==(covariant BlogModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.title == title &&
        other.content == content &&
        other.images == images &&
        listEquals(other.views, views) &&
        listEquals(other.likes, likes) &&
        other.updated == updated &&
        other.created == created;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        title.hashCode ^
        content.hashCode ^
        images.hashCode ^
        views.hashCode ^
        likes.hashCode ^
        updated.hashCode ^
        created.hashCode;
  }
}
