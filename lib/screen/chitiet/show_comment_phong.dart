import 'package:flutter/material.dart';
import '../../modal/comment_modal.dart';

class ShowCommentPhong extends StatelessWidget {
  const ShowCommentPhong({super.key, required this.comment});

  final List<Comments> comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: comment.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index2) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(child: Icon(Icons.person)),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            comment[index2].users!.username ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(comment[index2].noidung ?? ''),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
      ],
    );
  }
}
