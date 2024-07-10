import 'package:equatable/equatable.dart';

class Post extends Equatable {
  String? id;
  final String title;
  final String description;

  Post({
    this.id,
    required this.title,
    required this.description,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [title];
}
