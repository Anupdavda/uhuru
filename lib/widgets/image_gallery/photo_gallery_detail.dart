import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


class PhotoGalleryDetail extends StatefulWidget {
  final List imagePaths;
  final int currentIndex;

  PhotoGalleryDetail(
      {Key key, @required this.imagePaths, @required this.currentIndex})
      : super(key: key);

  @override
  _PhotoGalleryDetailState createState() =>
      _PhotoGalleryDetailState();
}

class _PhotoGalleryDetailState
    extends State<PhotoGalleryDetail> {
  int _currentIndex;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: <Widget>[
        _buildPhotoViewGallery(),
      
      ],
    );
  }

  


  PhotoViewGallery _buildPhotoViewGallery() {
    return PhotoViewGallery.builder(
      itemCount: widget.imagePaths.length,
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(widget.imagePaths[index]),
          //AssetImage(widget.imagePaths[index]),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
        );
      },
      enableRotation: false,
      scrollPhysics: const BouncingScrollPhysics(),
      pageController: _pageController,
      // ignore: deprecated_member_use
      loadingChild:Center(child: CircularProgressIndicator()),
      
      onPageChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
