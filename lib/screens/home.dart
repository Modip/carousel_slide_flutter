import 'dart:ui';

import 'package:carouselslide/data.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentindex = 0;

  double sizeBottom = 160;
  bool showDetail = false;

  void _moveDetailWidget() {
    setState(() {
      if (sizeBottom == 160) {
        sizeBottom = 95;
        showDetail = false;
      } else if (sizeBottom == 95) {
        sizeBottom = 160;
        showDetail = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 750),
            child: Container(
              key: ValueKey<int>(currentindex),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgs[currentindex]), fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
          ),
          PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentindex = value;
                });
              },
              itemCount: allimages.length,
              itemBuilder: (context, int index) {
                final picture = allimages[index];
                return Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 800),
                      bottom: sizeBottom,
                      left: 35,
                      right: 35,
                      child: Container(
                        height: height * .08,
                        decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                picture.title,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                picture.place,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 35,
                      right: 35,
                      child: InkWell(
                        onTap: () {
                          setState(
                            () {
                              _moveDetailWidget();
                            },
                          );
                        },
                        child: Container(
                          height: height * .6,
                          width: width * .8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(16),
                                  topRight: const Radius.circular(16),
                                  bottomLeft: showDetail
                                      ? const Radius.circular(16)
                                      : const Radius.circular(0),
                                  bottomRight: showDetail
                                      ? const Radius.circular(16)
                                      : const Radius.circular(0)),
                              image: DecorationImage(
                                  image: AssetImage(picture.image),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
