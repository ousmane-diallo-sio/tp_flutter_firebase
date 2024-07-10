import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_flutter_firebase/domain/post/bloc/post_bloc.dart';
import 'package:tp_flutter_firebase/domain/post/models/post.dart';
import 'package:tp_flutter_firebase/domain/post/post_repository.dart';
import 'package:tp_flutter_firebase/screens/post_creation_screen.dart';
import 'package:tp_flutter_firebase/screens/post_detail_screen.dart';
import 'package:tp_flutter_firebase/screens/post_list_screen.dart';
import 'package:tp_flutter_firebase/screens/post_update_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _postRepository = PostRepository();

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context,
            GoRouterState state) => const PostListScreen(),
      ),
      GoRoute(
        path: '/detail',
        builder: (BuildContext context,
            GoRouterState state) {
          final post = state.extra as Post;
          return PostDetailScreen(post: post);
        },
      ),
      GoRoute(
        path: '/create',
        builder: (BuildContext context, GoRouterState state) =>
            PostCreationScreen(),
      ),
      GoRoute(
        path: '/update',
        builder: (BuildContext context, GoRouterState state) {
          final post = state.extra as Post;
          return PostUpdateScreen(post: post);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(_postRepository),
      child: MaterialApp.router(
        routerConfig: _router,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}