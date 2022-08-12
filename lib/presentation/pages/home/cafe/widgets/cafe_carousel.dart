import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CafeCarousel extends StatefulWidget {
  const CafeCarousel({Key? key}) : super(key: key);

  @override
  State<CafeCarousel> createState() => Cafe_CarouselState();
}

class Cafe_CarouselState extends State<CafeCarousel> {
  List<dynamic> imgSlider = <Color>[Colors.black, Colors.amber, Colors.pink];

  int _sliderCurrent = 0;
  final CarouselController _sliderController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CarouselSlider.builder(
          itemCount: imgSlider.length,
          carouselController: _sliderController,
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _sliderCurrent = index;
              });
            },
          ),
          itemBuilder: (context, index, realIdx) {
            return Container(
              width: 343,
              height: 88,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imgSlider[index].toString()),
                ),
              ),
            );
          },
        ),
        Positioned(
          // top: 75,
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgSlider.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _sliderController.animateToPage(entry.key),
                child: Container(
                  width: 25,
                  height: 2,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.white70)
                        .withOpacity(
                      _sliderCurrent == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
