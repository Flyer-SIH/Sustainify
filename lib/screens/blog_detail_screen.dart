import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({
    Key? key,
    required this.networkImage,
    required this.heading,
    required this.content,
    this.method,
  }) : super(key: key);

  final String networkImage;
  final String heading;
  final String content;
  final String? method;

  void _shareBlog(BuildContext context) {
    // Add code to share the blog content here
  }

  void _addToFavorites(BuildContext context) {
    // Add code to save the blog as a favorite here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn in Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareBlog(context),
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => _addToFavorites(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              networkImage,
              height: 200, // Adjust the image height as needed
              width: double.infinity, // Make the image take the full width
              fit: BoxFit.cover, // Cover the entire image container
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                heading,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                content.isEmpty ? 'No content available.' : content,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.36,
                ),
              ),
            ),
            if (method != null) ...[
              const Divider(), // Horizontal line separator
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Methods -',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                    height: 1.3,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  method!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.36,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
