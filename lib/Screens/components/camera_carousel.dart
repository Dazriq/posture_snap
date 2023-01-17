import 'package:flutter/material.dart';
import 'dart:async';

class CameraCarousel extends StatefulWidget {
  const CameraCarousel({
    Key? key,
  }) : super(key: key);

  @override
  State<CameraCarousel> createState() => _CameraCarouselState();
}

class _CameraCarouselState extends State<CameraCarousel> {
  late PageController _pageController;

  List<String> images = [
    "assets/images/img4.png",
    "assets/images/img1.png",
    "assets/images/img3.png",
    "assets/images/img2.png",

  ];

  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    // Timer(Duration(microseconds: 2000), () {
    // });
    Timer.periodic(
      Duration(seconds: 3),
      (Timer timer) {
        activePage++;
        _pageController.animateToPage(
          activePage,
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeOutSine,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;
                return slider(images, pagePosition, active);
              }),
        ),
      ],
    );
  }
}

AnimatedContainer slider(images, pagePosition, active) {
  double margin = active ? 10 : 20;

  return AnimatedContainer(
    duration: Duration(milliseconds: 1000),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
        //border: Border.all(color: Color(0XFF0D6EFD), width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
            image: AssetImage(images[pagePosition % images.length]))),
  );
}

imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: EdgeInsets.all(10),
      child: Image.network(images[pagePosition]),
    ),
  );
}

// List<Widget> indicators(imagesLength, currentIndex) {
//   return List<Widget>.generate(imagesLength, (index) {
//     return Container(
//       margin: EdgeInsets.all(3),
//       width: 10,
//       height: 10,
//       decoration: BoxDecoration(
//           color: currentIndex == index ? Colors.black : Colors.black26,
//           shape: BoxShape.circle),
//     );
//   });
// }
