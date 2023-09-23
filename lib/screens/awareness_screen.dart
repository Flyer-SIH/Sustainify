import 'package:flutter/material.dart';
import 'package:sustainify/dummy_data/articles_data.dart';
import 'package:sustainify/screens/blog_detail_screen.dart';

class AwarenessScreen extends StatelessWidget {
  const AwarenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: ListView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlogDetailScreen(
                            networkImage: details[index].photo,
                            heading: details[index].title,
                            content: details[index].about,
                            method: details[index].methods,
                          )));
            },
            child: BlogCard(
              networkImage: details[index].photo,
              heading: details[index].title,
              content: details[index].about,
            ),
          );
        },
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.networkImage, required this.heading, required this.content});

  final String networkImage;
  final String heading;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.transparent),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 6.0,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.transparent),
                image: DecorationImage(image: NetworkImage(networkImage), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
