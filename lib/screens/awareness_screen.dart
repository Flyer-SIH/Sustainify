import 'package:flutter/material.dart';
import 'package:sustainify/models/blog_model.dart';

class AwarenessScreen extends StatelessWidget {
  AwarenessScreen({super.key});
  final List<Article> articles = [
    Article(heading: 'Article 1', content: 'Content for Article 1'),
    Article(heading: 'Article 2', content: 'Content for Article 2'),
    Article(heading: 'Article 3', content: 'Content for Article 3'),
    Article(heading: 'Article 4', content: 'Content for Article 4'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return BlogCard(
            assetImage: 'blog_image_$index',
            heading: articles[index].heading,
            content: articles[index].content,
          );
        },
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.assetImage, required this.heading, required this.content});

  final String assetImage;
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
                image: DecorationImage(image: AssetImage(assetImage), fit: BoxFit.fill),
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
