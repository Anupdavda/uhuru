import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';
import 'package:uhuru/widgets/image_gallery/photo_gallery_detail.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _current = 0;

  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _current);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PersonalHomeList loadedApartment =
        Provider.of<PersonalHomeList>(context, listen: true);

    List imageList = loadedApartment.currentApartment.imageUrl;

    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    return imageList.isEmpty
        ? Container(
            child: const Center(
                child: const Text(
              'No Images',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            )),
            height: 250,
            width: double.infinity,
            color: Colors.black54)
        : Container(
            child: Column(
              children: [
                CarouselSlider(
                  items: imageList.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width:  MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: Ink(
                            child: InkWell(
                              child: Image.network(imageUrl, fit: BoxFit.fill),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return PhotoGalleryDetail(
                                    currentIndex: _current,
                                    imagePaths: imageList,
                                  );
                                }),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    initialPage: 0,
                    autoPlay: false,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                      _pageController.jumpToPage(index);
                    },
                  ),
                ),
              const  SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(imageList, (index, imageUrl) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape:  BoxShape.circle,
                            color: _current == index
                                ? Colors.black
                                : Colors.black54),
                      );
                    })),
              ],
            ),
          );
  }
}
