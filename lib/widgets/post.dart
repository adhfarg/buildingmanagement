import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final Post post;
  final int
      index; // This is no longer needed but we'll keep it for now to avoid breaking other code

  const PostWidget({
    Key? key,
    required this.index,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String profilePicUrl =
        'https://ui-avatars.com/api/?name=${Uri.encodeComponent(post.authorName)}&background=random&color=fff';

    return Card(
      color: const Color(0xFF1A1F35),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1F35),
              const Color(0xFF1A1F35).withOpacity(0.8),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profilePicUrl),
                      radius: 20,
                      backgroundColor: Colors.blue.withOpacity(0.2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.authorName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          timeago.format(post.timestamp),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {},
                    color: Colors.grey[400],
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                post.content,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[800]!,
                      width: 1,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInteractionButton(
                      context,
                      Icons.chat_bubble_outline_rounded,
                      post.comments.toString(),
                      () => Provider.of<PostModel>(context, listen: false)
                          .incrementComments(post.id),
                    ),
                    _buildInteractionButton(
                      context,
                      Icons.repeat_rounded,
                      post.reposts.toString(),
                      () => Provider.of<PostModel>(context, listen: false)
                          .incrementReposts(post.id),
                    ),
                    _buildInteractionButton(
                      context,
                      Icons.favorite_border_rounded,
                      post.likes.toString(),
                      () => Provider.of<PostModel>(context, listen: false)
                          .incrementLikes(post.id),
                    ),
                    _buildInteractionButton(
                      context,
                      Icons.bar_chart_rounded,
                      post.views.toString(),
                      () => Provider.of<PostModel>(context, listen: false)
                          .incrementViews(post.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_outlined, size: 18),
                      onPressed: () {},
                      color: Colors.grey[400],
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInteractionButton(
    BuildContext context,
    IconData icon,
    String count,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.grey[400]),
          const SizedBox(width: 4),
          Text(
            count,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
