import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_flutter_firebase/domain/post/models/post.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erreur lors de la récupération des posts'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data?.docs;
          if (documents == null || documents.isEmpty) {
            return const Center(
              child: Text('Aucun post disponible'),
            );
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final data = documents[index].data();
              if (data == null) return const SizedBox();
              final postData = data as Map<String, dynamic>;
              final post = Post.fromJson(postData);
              post.id = documents[index].id;
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.description),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => context.push('/update', extra: post),
                ),
                onTap: () => context.push('/detail', extra: post),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.push('/create'),
            tooltip: 'Firestore',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
