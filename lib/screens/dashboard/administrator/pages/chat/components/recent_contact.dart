import 'package:flutter/material.dart';

class RecentContact extends StatelessWidget {
  RecentContact({Key? key}) : super(key: key);

  final List recentContactItems = [
    {
      "pseudo": "John Doe",
      "photo": "https://pfps.gg/assets/pfps/6143-boruto-kawaki.png",
    },
    {
      "pseudo": "Cherida B",
      "photo":
          "https://wallpapers-clan.com/wp-content/uploads/2022/07/anime-default-pfp-27.jpg",
    },
    {
      "pseudo": "Harley G",
      "photo":
          "https://wallpapers-clan.com/wp-content/uploads/2022/07/anime-default-pfp-5.jpg"
    },
    {
      "pseudo": "Foo Bar",
      "photo":
          "https://wallpapers-clan.com/wp-content/uploads/2022/07/anime-default-pfp-5.jpg"
    },
    {
      "pseudo": "Foo Baz",
      "photo":
          "https://wallpapers-clan.com/wp-content/uploads/2022/07/anime-default-pfp-5.jpg"
    },
    {
      "pseudo": "Picachu",
      "photo":
          "https://wallpapers-clan.com/wp-content/uploads/2022/07/anime-default-pfp-5.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: recentContactItems.map((story) {
        return Container(
          margin: const EdgeInsets.only(left: 0, right: 5.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/story-circle.png',
                    width: 70,
                    height: 70,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    backgroundImage: NetworkImage(story['photo']),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(story['pseudo'],
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 6),
            ],
          ),
        );
      }).toList()),
    );
  }
}
