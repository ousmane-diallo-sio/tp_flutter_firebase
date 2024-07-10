import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_flutter_firebase/domain/post/bloc/post_bloc.dart';
import 'package:tp_flutter_firebase/domain/post/models/post.dart';

class PostUpdateScreen extends StatelessWidget {
  final Post post;

  PostUpdateScreen({Key? key, required this.post}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = post.title;
    _descriptionController.text = post.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mise à jour de post'),
        leading:
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.pop(),
          ),
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
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state.status == PostStatus.updatingPost) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () => _updatePost(context),
                  child: const Text('Mettre à jour le post'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updatePost(BuildContext context) {
    final updatedPost = Post(
      id: post.id, // Ensure the ID is preserved
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.read<PostBloc>().add(UpdatePostEvent(post: updatedPost));
  }
}