import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';

class PhotoGalleryDetail extends StatefulWidget {
  final List imagePaths;
  final int currentIndex;

  PhotoGalleryDetail(
      {Key key, @required this.imagePaths, @required this.currentIndex})
      : super(key: key);

  @override
  _PhotoGalleryDetailState createState() => _PhotoGalleryDetailState();
}

class _PhotoGalleryDetailState extends State<PhotoGalleryDetail> {
  int _currentIndex;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
    debugPrint(_currentIndex.toString());
  }

  void displayModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () => {
                          deleteSelectedPicture(),
                          Navigator.of(context).pop(),
                        }),
                new ListTile(
                  leading: new Icon(Icons.cancel),
                  title: new Text('Cancel'),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(Icons.more_vert_rounded),
              onPressed: () {
                displayModalBottomSheet(context);
              })
        ],
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
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
        );
      },
      enableRotation: false,
      scrollPhysics: const BouncingScrollPhysics(),
      pageController: _pageController,
      loadingBuilder: (context, progress) =>
          Center(child: CircularProgressIndicator()),
      onPageChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  deleteSelectedPicture() async {
    PersonalHomeList loadedApartment =
        Provider.of<PersonalHomeList>(context, listen: true);
    List imageList = loadedApartment.currentApartment.imageUrl;
    try {
      if (widget.imagePaths[_currentIndex] == imageList[_currentIndex]) {
        debugPrint(imageList[_currentIndex].toString());

        Firestore.instance
            .collection('apartments')
            .document(loadedApartment.currentApartment.id)
            .updateData({
          'imageUrl': FieldValue.arrayRemove([imageList[_currentIndex]])
        }).then((_) {
          print("success!");
        });

        StorageReference storageReference = await FirebaseStorage.instance
            .getReferenceFromUrl(imageList[_currentIndex]);
        await storageReference.delete();
        debugPrint('Image removed from the storage');
        imageCache.clear();
        setState(() {
          loadedApartment.currentApartment.imageUrl.removeAt(_currentIndex);
        });
        if (loadedApartment.currentApartment.imageUrl.isEmpty) {
          setState(() {
            Navigator.of(context).popUntil((route) => route.isFirst);
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
