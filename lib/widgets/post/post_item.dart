import 'package:flutter/material.dart';
import 'package:surface/types/post.dart';

class PostItem extends StatelessWidget {
  final SnPost data;
  const PostItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}

class _PostContentPublisher extends StatelessWidget {
  const _PostContentPublisher({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
