import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_firebase/domain/post/bloc/post_bloc.dart';
import 'package:tp_flutter_firebase/domain/post/models/post.dart';

class PostCreationScreen extends StatelessWidget {
  PostCreationScreen({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Création de post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submitPost(context),
              child: const Text('Créer un post'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPost(BuildContext context) {
    final post = Post(
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.read<PostBloc>().add(CreatePostEvent(post: post));
  }
}