import 'dart:ffi';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainify/controllers/screen_controller.dart';
import 'package:sustainify/models/blogs/models.dart';
import 'package:sustainify/screens/blog_detail_screen.dart';
import 'package:sustainify/widgets/custom_app_bar.dart';

class AwarenessScreen extends StatelessWidget {
  AwarenessScreen({super.key});

  ScreenController screenController = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Explore',
        ),
        body: Obx(
          () => screenController.isDataFetched.value
              ? ListView.builder(
                  itemCount: screenController.fetchedArticles.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    final article = screenController.fetchedArticles[index];
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
                      child: Column(
                        children: [
                          BlogCard(
                            networkImage: article.urlToImage,
                            heading: article.title,
                            content: article.description,
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    );
                  },
                )
              : Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: Color.fromARGB(255, 150, 75, 0), size: 30),
              ),
        ));
  }
}

class BlogCard extends StatelessWidget {
  const BlogCard(
      {super.key,
      required this.networkImage,
      required this.heading,
      required this.content});

  final String? networkImage;
  final String? heading;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 218, 181),
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
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.transparent),
                  image: DecorationImage(
                      image: NetworkImage(networkImage!), fit: BoxFit.cover),
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
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
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
