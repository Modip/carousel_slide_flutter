import 'dart:ui';

import 'package:carouselslide/data.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int currentindex = 0;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Center(
          child: FractionallySizedBox(
            alignment: Alignment.center,
            heightFactor: .55,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentindex = value;
                });
              },
              itemCount: allimages.length,
              itemBuilder: (context, int index) {
                final picture = allimages[index];
                return FractionallySizedBox(
                  widthFactor: .8,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(picture.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
