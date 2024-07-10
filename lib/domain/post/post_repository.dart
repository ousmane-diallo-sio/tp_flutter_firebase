import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp_flutter_firebase/domain/post/models/post.dart';

abstract class PostRepositoryInterface {
  Future<List<Post>> getAllPosts();
  Future<Post> createPost(Post post);
  Future<Post> updatePost(Post post);
}

class PostRepository implements PostRepositoryInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Post>> getAllPosts() async {
    final querySnapshot = await _firestore.collection('posts').get();
    return querySnapshot.docs.map((doc) => Post.fromJson(doc.data())).toList();
  }

  @override
  Future<Post> createPost(Post post) async {
    final docRef = await _firestore.collection('posts').add(post.toJson());
    final docSnapshot = await docRef.get();
    return Post.fromJson(docSnapshot.data()!);
  }

  @override
  Future<Post> updatePost(Post post) async {
    await _firestore.collection('posts').doc(post.id).update(post.toJson());
    return post;
  }
}

