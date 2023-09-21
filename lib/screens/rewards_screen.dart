import 'package:expandable/expandable.dart';

import 'package:flutter/material.dart';
import 'package:sustainify/models.dart';

class RewardsScreen extends StatefulWidget {
  final List<Item> items;
  const RewardsScreen({Key? key, required this.items}) : super(key: key);

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  late ExpandableController controller;

  @override
  void initState() {
    super.initState();
    controller = ExpandableController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalPoints = widget.items.fold(0, (sum, item) => (item.count * item.points) + sum);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 5),
            totalPoints > 0
                ? RewardCup(items: widget.items)
                : const Center(
                    child: Text(""),
                  ),
            const SizedBox(height: 10),
            CoinsCup(items: widget.items),
            const SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                buildCard('User Name', [
                  "Flatten boxes before recycling them.",
                  "Remove all food and liquid from containers.",
                  "Throw your recycling in loose, instead of in a plastic bag (as plastic bags cannot be recycled).",
                  "Check it before you chuck it to make sure the ARL matches the bin you are putting it in."
                ])
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget buildCard(String title, List<String> _tips) => Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff69c0dc),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(3, 3), // changes position of shadow
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Column(children: <Widget>[
              ExpandablePanel(
                  controller: controller,
                  theme: const ExpandableThemeData(
                      tapBodyToCollapse: true, tapBodyToExpand: true, iconColor: Colors.white),
                  header: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        10, 10, 20, 20), //apply padding to LTRB, L:Left, T:Top, R:Right, B:Bottom
                    child: Text("Tips for managing $title waste",
                        style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                  collapsed: Text(
                    _tips[0] + " " + _tips[1],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                      children: _tips.map((strone) {
                    return Row(children: [
                      const Text(
                        "\u2022",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ), //bullet text
                      const SizedBox(width: 8, height: 5), //space between bullet and text
                      Expanded(
                        child: Text(
                          "$strone \n",
                          style: const TextStyle(fontSize: 14, color: Colors.white),
                        ), //text
                      ),
                    ]);
                  }).toList()),
                  builder: (_, collapsed, expanded) => Padding(
                      padding: const EdgeInsets.all(10).copyWith(top: 0),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                      )))
            ])),
      ));
}

class RewardCup extends StatelessWidget {
  final List<Item> items;
  const RewardCup({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [titleCard(title: "Your Reward"), RewardsBanner(items: items)],
        ));
  }
}

class CoinsCup extends StatelessWidget {
  final List<Item> items;
  const CoinsCup({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [const SizedBox(height: 10), titleCard(title: "Coins Earned"), CoinsBanner(items: items)],
        ));
  }
}

titleCard({String title = 'User Name'}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    ],
  );
}

class CoinsBanner extends StatelessWidget {
  final List<Item> items;
  const CoinsBanner({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentCoins = items.fold(0, (sum, item) => (item.count * item.points) + sum);
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(3, 3), // changes position of shadow
            ),
            const BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text.rich(TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "$currentCoins coins\n",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )),
              const Text.rich(TextSpan(
                text:
                    "For each recycled item, you get a different amount of coins that you can spend through Moms Store Nepal.",
                style: TextStyle(color: Colors.black, fontSize: 14),
              )),
            ]),
          ),
          Expanded(
            flex: 1,
            child: Image.asset('assets/images/coins.png', height: 100, width: 350),
          )
        ]));
  }
}

class RewardsBanner extends StatelessWidget {
  final List<Item> items;
  const RewardsBanner({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalPoints = items.fold(0, (sum, item) => (item.count * item.points) + sum);
    // var activeReward = rewardNotifier.getActiveReward(totalPoints);

    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF4A3298),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(3, 3), // changes position of shadow
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: const Row(children: <Widget>[
          // Expanded(
          //   flex: 1,
          //   child: Image.asset(activeReward.imageURL, height: 160, width: 350),
          // ),
          Expanded(
            flex: 2,
            child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text.rich(TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(text: "100"),
                    ],
                  )),
                  SizedBox(height: 5),
                  Text.rich(TextSpan(
                    text:
                        "You have recycled more than ${100 * 0.1} kg of carbon footprints. We thank you for your contribution. Keep taking care of our planet and recycle to get more rewards and coins.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ])),
          ),
        ]));
  }
}
