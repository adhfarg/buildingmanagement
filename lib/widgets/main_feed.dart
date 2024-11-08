import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'post_composer.dart';
import 'post.dart';
import 'right_sidebar.dart';

class MainFeed extends StatelessWidget {
  final bool showSidebarContent;

  const MainFeed({Key? key, required this.showSidebarContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PostModel>(
      builder: (context, postModel, child) {
        return ListView(
          children: [
            const PostComposer(),
            ...postModel.posts.map((post) => PostWidget(post: post)),
            if (showSidebarContent) const RightSidebar(),
          ],
        );
      },
    );
  }
}
