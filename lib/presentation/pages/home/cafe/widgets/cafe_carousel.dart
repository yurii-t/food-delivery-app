import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CafeCarousel extends StatefulWidget {
  final String restaurantImage;
  const CafeCarousel({required this.restaurantImage, Key? key})
      : super(key: key);

  @override
  State<CafeCarousel> createState() => Cafe_CarouselState();
}

class Cafe_CarouselState extends State<CafeCarousel> {
  int _sliderCurrent = 0;
  final CarouselController _sliderController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<Image> imgSlider = [
      Image.network(
        widget.restaurantImage,
        fit: BoxFit.cover,
      ),
      Image.network(
        widget.restaurantImage,
        colorBlendMode: BlendMode.difference,
        fit: BoxFit.cover,
        color: Colors.amber,
      ),
      Image.network(
        widget.restaurantImage,
        colorBlendMode: BlendMode.colorBurn,
        color: Colors.red,
        fit: BoxFit.cover,
      ),
    ];

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
              clipBehavior: Clip.hardEdge,
              width: 343,
              height: 88,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: imgSlider[index],
            );
          },
        ),
        Positioned(
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
