import 'package:flutter/material.dart';
import 'package:sustainify/models/blog_model.dart';

class AwarenessScreen extends StatelessWidget {
  AwarenessScreen({super.key});
  final List<Article> articles = [
    Article(
        heading: 'What is domestic waste? - The Waste Management & Recycling Blog',
        content:
            'Domestic waste, also known as household waste, includes food waste, recyclables, general waste, and garden waste, with disposal options ranging from curbside collection to recycling centers. Hazardous waste, such as medical waste and chemicals, should be properly disposed of through council-run recycling centers.  '),
    Article(
        heading: 'How to properly manage your household waste?',
        content:
            'The article stresses the significance of waste source segregation, government regulations, and the advantages of decentralized waste management, particularly composting, with a focus on modern solutions like GoClean Organic Waste Reprocessors.'),
    Article(
        heading: 'Effective Solid Waste Management is imperative for achieving circular economy',
        content:
            'During a visit, the Norwegian Ambassador and the Director General of the Centre for Science and Environment applauded Nationwide Waste Management Services\' focus on source segregation and waste baling as critical steps for effective waste management, promoting environmental awareness and cleaner practices.'),
    Article(
        heading: 'Plastic Waste: The necessary evil?',
        content:
            'Efforts to address plastic waste and promote recycling, including plastic neutrality and responsible taxation, are essential in mitigating environmental harm while emphasizing the importance of source segregation for efficient waste management.'),
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
