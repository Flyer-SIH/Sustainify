import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({
    Key? key,
    this.networkImage,
    this.heading,
    this.content,
    this.description,
  }) : super(key: key);

  final String? networkImage;
  final String? heading;
  final String? content;
  final String? description;

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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
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
            if (networkImage != null)
              Image.network(
                networkImage!,
                height: 200, // Adjust the image height as needed
                width: double.infinity, // Make the image take the full width
                fit: BoxFit.cover, // Cover the entire image container
              ),
            const SizedBox(
              height: 16,
            ),
            if (heading != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  heading!,
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
            if (content != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  content!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.36,
                  ),
                ),
              ),
            if (description != null) ...[
              const Divider(), // Horizontal line separator
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  description!,
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
