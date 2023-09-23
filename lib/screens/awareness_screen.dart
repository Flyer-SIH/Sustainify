import 'package:flutter/material.dart';
import 'package:sustainify/models/blogs/articles_resource.dart';
import 'package:sustainify/models/blogs/models.dart';
import 'package:sustainify/screens/blog_detail_screen.dart';
import 'package:sustainify/widgets/custom_app_bar.dart';

class AwarenessScreen extends StatefulWidget {
  const AwarenessScreen({Key? key}) : super(key: key);

  @override
  _AwarenessScreenState createState() => _AwarenessScreenState();
}

class _AwarenessScreenState extends State<AwarenessScreen> {
  late Future<List<Articles>> futureArticles;

  @override
  void initState() {
    super.initState();
    // Fetch the list of articles when the widget initializes
    futureArticles = fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Explore',
      ),
      body: FutureBuilder<List<Articles>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final articles = snapshot.data;
            return ListView.builder(
              itemCount: articles!.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailScreen(
                          networkImage: article.urlToImage,
                          heading: article.title,
                          content: article.content,
                          description: article.description,
                        ),
                      ),
                    );
                  },
                  child: BlogCard(
                    networkImage: article.urlToImage,
                    heading: article.title,
                    content: article.description,
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.networkImage, required this.heading, required this.content});

  final String? networkImage;
  final String? heading;
  final String? content;

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
            if (networkImage != null)
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.transparent),
                  image: DecorationImage(image: NetworkImage(networkImage!), fit: BoxFit.cover),
                ),
              ),
            if (heading != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (content != null)
                      Text(
                        content!,
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
