import 'dart:ui';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sustainify/controllers/screen_controller.dart';
import 'package:sustainify/models/blogs/models.dart';
import 'package:sustainify/screens/blog_detail_screen.dart';
import 'package:sustainify/screens/videoplay_screen.dart';
import 'package:sustainify/widgets/custom_app_bar.dart';
import 'package:file_picker/file_picker.dart';

class AwarenessScreen extends StatelessWidget {
  AwarenessScreen({super.key});

  ScreenController screenController = Get.find<ScreenController>();
  List<String> items = [
    "Newspaper",
    "Jute Bag",
    "CardBoard",
    "Wall Decoration"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(
          title: 'Explore',
          implyLeading: false,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(
                  () => TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: screenController.isBlog.value
                            ? Color.fromARGB(73, 247, 188, 167)
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: screenController.isBlog.value
                                    ? const Color.fromARGB(255, 150, 75, 0)
                                    : Colors.transparent),
                            // side: BorderSide(color: Colors.brown),
                            borderRadius: BorderRadius.circular(15)),
                        textStyle: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        screenController.isBlog.value = true;
                      },
                      child: Text(
                        'Blog',
                        style: TextStyle(
                            color: screenController.isBlog.value
                                ? Color.fromARGB(255, 150, 75, 0)
                                : Colors.black),
                      )),
                ),
                Obx(
                  () => TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: !screenController.isBlog.value
                            ? Color.fromARGB(73, 247, 188, 167)
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: !screenController.isBlog.value
                                    ? const Color.fromARGB(255, 150, 75, 0)
                                    : Colors.transparent),
                            // side: BorderSide(color: Colors.brown),
                            borderRadius: BorderRadius.circular(15)),
                        textStyle: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        screenController.isBlog.value = false;
                      },
                      child: Text(
                        'Video',
                        style: TextStyle(
                            color: !screenController.isBlog.value
                                ? Color.fromARGB(255, 150, 75, 0)
                                : Colors.black),
                      )),
                ),
              ],
            ),
            Obx(
              () => screenController.isBlog.value
                  ? Expanded(
                      child: FutureBuilder<List<Articles>>(
                        future: screenController.fetchedArticles,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: LoadingAnimationWidget.dotsTriangle(
                                  color: Color.fromARGB(255, 150, 75, 0),
                                  size: 30),
                            );
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
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    )
                  : !screenController.videoUploadScreen.value
                      ? Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 250,
                                  child: SearchAnchor(
                                      viewShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      builder: (BuildContext context,
                                          SearchController controller) {
                                        return SearchBar(
                                          controller: controller,
                                          padding:
                                              const MaterialStatePropertyAll<
                                                      EdgeInsets>(
                                                  EdgeInsets.symmetric(
                                                      horizontal: 16.0)),
                                          onTap: () {
                                            controller.openView();
                                          },
                                          onSubmitted: (string) {
                                            print("heyyyyy");
                                            controller.closeView(string);
                                          },
                                          onChanged: (_) {
                                            controller.openView();
                                          },
                                          leading: const Icon(Icons.search),
                                        );
                                      },
                                      suggestionsBuilder: (BuildContext context,
                                          SearchController controller) {
                                        return List<ListTile>.generate(
                                            items.length, (int index) {
                                          final String item = items[index];
                                          return ListTile(
                                            title: Text(item),
                                            onTap: () {
                                              controller.closeView(item);
                                            },
                                          );
                                        });
                                      }),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    // backgroundColor:
                                    //     Color.fromARGB(255, 150, 75, 0)
                                  ),
                                  onPressed: () {
                                    screenController.videoUploadScreen.value =
                                        true;
                                  },
                                  child: Icon(
                                    Icons.add,
                                    // color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                height: 520,
                                child: ListView.builder(
                                    itemCount:
                                        screenController.documents.length,
                                    itemBuilder: ((context, index) => Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {

                                                Get.to(VideoPlayerScreen(videoLink: 'https://cloud.appwrite.io/v1/storage/buckets/651ab8f5bd29a092dafa/files/${screenController.documents[index].data["VideoID"]}/view?project=6516c52b266f1fb10835&mode=admin'));
                                              },
                                              child: VlogCard(
                                                  networkImage:
                                                      'https://cloud.appwrite.io/v1/storage/buckets/651ab91eecc8cb567fd2/files/${screenController.documents[index].data["VideoID"]}/view?project=6516c52b266f1fb10835&mode=admin',
                                                  heading: screenController
                                                      .documents[index]
                                                      .data["Name"],
                                                  content: "By " +
                                                      screenController
                                                          .documents[index]
                                                          .data["Uname"]),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ))),
                              ),
                            ),
                          ],
                        )
                      : Expanded(
                          child: Center(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Upload your Video",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape: CircleBorder()),
                                                onPressed: () {
                                                  screenController
                                                      .videoUploadScreen
                                                      .value = false;
                                                },
                                                child:
                                                    Icon(Icons.cancel_outlined))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                            width: 300,
                                            child: TextField(
                                              controller: screenController
                                                  .nameController,
                                              decoration: InputDecoration(
                                                  hintText: "Name",
                                                  hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromARGB(
                                                          145, 88, 86, 86)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              206, 174, 133, 91)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color.fromARGB(206, 174, 133, 91)),
                                                      borderRadius: BorderRadius.circular(15)),
                                                  filled: true,
                                                  fillColor: Color.fromARGB(71, 207, 164, 129)),
                                            )),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          height: 60,
                                          child: MultiSelectDropDown(
                                            hintColor:
                                                Color.fromARGB(145, 88, 86, 86),
                                            borderColor: Color.fromARGB(
                                                206, 174, 133, 91),
                                            backgroundColor: Color.fromARGB(
                                                71, 207, 164, 129),
                                            hint: 'Select a Tag',
                                            onOptionSelected: (List<ValueItem>
                                                selectedOptions) {
                                              print(selectedOptions);
                                              screenController.selectedTags =
                                                  selectedOptions;
                                            },
                                            borderWidth: 1,
                                            focusedBorderColor: Color.fromARGB(
                                                206, 174, 133, 91),
                                            options: const <ValueItem>[
                                              ValueItem(label: 'Chairperson'),
                                              ValueItem(
                                                  label: 'Vice Chairperson'),
                                              ValueItem(label: 'Content Team'),
                                              ValueItem(
                                                  label: 'Marketing Team'),
                                              ValueItem(label: 'Design Team'),
                                              ValueItem(
                                                label: 'Tech Team',
                                              ),
                                              ValueItem(label: 'Project Team'),
                                            ],
                                            selectionType: SelectionType.multi,
                                            chipConfig: const ChipConfig(
                                                wrapType: WrapType.scroll),
                                            dropdownHeight: 300,
                                            optionTextStyle:
                                                const TextStyle(fontSize: 16),
                                            selectedOptionIcon:
                                                const Icon(Icons.check_circle),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Text(
                                          "Upload a Thumbnail for your Video (.png)",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await screenController
                                                .pickThumbnailfile();
                                          },
                                          child: Text(
                                            "Upload Thumbnail",
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        screenController.pickedThumbnail.value
                                            ? TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          131, 199, 236, 201),
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: Colors
                                                              .green.shade700),
                                                      // side: BorderSide(color: Colors.brown),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40)),
                                                  textStyle: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                onPressed: null,
                                                child: Text('Thumbnail Picked',
                                                    style: TextStyle(
                                                        color: Colors.green)))
                                            : SizedBox(),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Text(
                                          "Upload your Video File (.mp4)",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await screenController
                                                .pickVideofile();
                                          },
                                          child: Text(
                                            "Upload Video ",
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        screenController.pickedVideo.value
                                            ? TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          131, 199, 236, 201),
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: Colors
                                                              .green.shade700),
                                                      // side: BorderSide(color: Colors.brown),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40)),
                                                  textStyle: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                onPressed: null,
                                                child: Text('Video Picked',
                                                    style: TextStyle(
                                                        color: Colors.green)))
                                            : SizedBox(),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            screenController
                                                .isVideoPosting.value = true;
                                            await screenController.postVideo();
                                          },
                                          child: Text(
                                            "Post the Video",
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 150, 75, 0)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                screenController.isVideoPosting.value
                                    ? BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10),
                                        child: Center(
                                            child: LoadingAnimationWidget
                                                .threeRotatingDots(
                                                    color: Color.fromARGB(
                                                        255, 150, 75, 0),
                                                    size: 30)),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
            ),
          ],
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
                  color: Color.fromARGB(72, 194, 220, 241),
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

class VlogCard extends StatelessWidget {
  const VlogCard(
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
                  color: Color.fromARGB(72, 194, 220, 241),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.transparent),
                  image: DecorationImage(
                      image: NetworkImage(networkImage!), fit: BoxFit.cover),
                ),
                child: Center(
                    child: Icon(
                  Icons.play_arrow_rounded,
                  color: Color.fromARGB(137, 10, 10, 10),
                  size: 50,
                )),
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
