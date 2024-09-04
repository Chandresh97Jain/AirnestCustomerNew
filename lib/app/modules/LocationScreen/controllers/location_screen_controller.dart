import 'dart:developer';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/HomeScreen/home_models.dart';


class LocationScreenController extends GetxController {
  //TODO: Implement LocationScreenController

  late GoogleMapController mapController;
  final count = 0.obs;

  final latitude = ''.obs;
  final longitude = ''.obs;
  final address = ''.obs;
  final isFav = false.obs;
  final isLoadingFavUnfav = false.obs;

  final LatLng initialCameraPosition = const LatLng(37.7749, -122.4194); // Initial map position

  //
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  final currentLocation = Rx<LatLng?>(null);

  final isLoading  = false.obs;
  // Rx<LocationData?> currentLocation = Rx<LocationData?>(null);

  // Future<void> _getLocation() async {
  //   try {
  //     var location = await locationService.getLocation();
  //     currentLocation = LatLng(location.latitude!, location.longitude!);
  //
  //     currentLocation.onLocationChanged.listen((LocationData currentLocation) {
  //       setState(() {
  //         currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //       });
  //     });
  //   } on Exception {
  //     _currentLocation = null;
  //   }
  // }
  //
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (currentLocation.value != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation.value!, zoom: 15),
      ));
    }
  }

  Future<void> requestLocationPermission() async {
    isLoading(true);
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Check if location services are enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if location permissions are granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get the current location
    _locationData = await location.getLocation();
    // currentLocation.value = _locationData;

    print("current - Location ----- ➡️📍 $currentLocation");
    isLoading(false);
  }
  // final List<LatLng> locations = [
  //   LatLng(22.715819722733947, 75.85179565882456),
  //   LatLng(22.71721724304995, 75.85172351370672),
  //   LatLng(22.715021133289138, 75.85590793054224),
  //   LatLng(22.71781617595961, 75.861968120442),
  //   LatLng(22.719746053059517, 75.84948701505323),
  //   LatLng(22.710628808056637, 75.862418291819),
  //   LatLng(22.714534236203743, 75.85598927792084),
  //   LatLng(22.71026718870329, 75.8618694735594),
  //
  // ];

  final List<LatLng> locations = [];
  // final Map<String, Marker>markers = {};
  final List<Marker> markers = [];
  final List<Marker> markers2 = [];

  @override
  void onInit() {
    address.value = Get.parameters['address']!;
    latitude.value = Get.parameters['latitude']!;
    longitude.value = Get.parameters['longitude']!;

    log("latitude = $latitude, longitude = $longitude");
    updateCurrentLocationFromParameters();
    // currentLocation.value = LatLng(double.parse(Get.parameters['latitude']!), double.parse(Get.parameters['longitude']!));
    super.onInit();
    nearByMaidApi();
    requestLocationPermission();
    // locations.forEach((location) {
    //   final marker = Marker(
    //     markerId: MarkerId(location.toString()),
    //     position: location,
    //     infoWindow: InfoWindow(
    //       title: 'Location',
    //       snippet: location.toString(),
    //     ),
    //   );
    //   markers[location.toString()] = marker;
    // });
  }

  void updateCurrentLocationFromParameters() {
    final latitudeStr = Get.parameters['latitude'];
    final longitudeStr = Get.parameters['longitude'];

    if (latitudeStr != null && longitudeStr != null) {
      try {
        final latitude = double.parse(latitudeStr);
        final longitude = double.parse(longitudeStr);
        currentLocation.value = LatLng(latitude, longitude);
      } catch (e) {
        log('Error parsing latitude or longitude: $e');
        // Handle the error or set a default value
        currentLocation.value = initialCameraPosition; // Set your default LatLng value
      }
    } else {
      log('Latitude or longitude parameters are missing');
      // Handle the case where parameters are missing
      currentLocation.value = initialCameraPosition; // Set your default LatLng value
    }
  }

  Future<BitmapDescriptor> createBitmapDescriptorFromAsset(
      String imageAssetPath) async {
    final ByteData byteData = await rootBundle.load(imageAssetPath);
    final Uint8List imageData = byteData.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(imageData);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;

    return BitmapDescriptor.fromBytes(
        Uint8List.view((await image.toByteData(format: ui.ImageByteFormat.png))!.buffer));
  }

  final nearByMaid = <NearByListModel>[].obs;
  Future<void> nearByMaidApi() async {

    nearByMaid.clear();
    locations.clear();
    markers.clear();

    try {

      isLoading(true);

      var response = await ApiService().nearByMaidApi();

      if (response['status'] == true) {
        List dataList = response['data'].toList();
        nearByMaid.value = dataList.map((json) => NearByListModel.fromJson(json)).toList();


        for (var item in nearByMaid) {
          isFavorite[item.id.toString()] = item.isFavorite == 1;
        }




        log("maidIcon -------  ");

        // for (var maid in near_by_maid) {
        //   var latitude = double.parse(maid.latitude);
        //   var longitude = double.parse(maid.longitude);
        //   // var image = ApiService.IMAGE_URL+maid.avatar;
        //   // BitmapDescriptor maidIcon = await createBitmapDescriptorFromAsset(maid.avatar);
        //   // print("maidIcon -------  ${maidIcon}");
        //   LatLng location = LatLng(latitude, longitude);
        //   locations.add(location);
        //
        //   // final marker = Marker(
        //   //   markerId: MarkerId(location.toString()),
        //   //   position: location,
        //   //   // icon: maidIcon,
        //   //   infoWindow: InfoWindow(
        //   //     title: 'Location',
        //   //     snippet: location.toString(),
        //   //   ),
        //   // );
        //   // markers.add(marker);
        //
        //   for (int i = 0; i < locations.length; i++) {
        //     final Uint8List markerIcon = await _getBytesFromAsset('assets/images/marker.png', 80);
        //     markers.add(
        //       Marker(
        //         markerId: MarkerId('marker_$i'),
        //         position: locations[i],
        //         icon: BitmapDescriptor.fromBytes(markerIcon),
        //         infoWindow: InfoWindow(
        //           title: 'Marker $i',
        //           snippet: 'This is marker $i',
        //         ),
        //       ),
        //     );
        //   }
        // }

        for (var user in nearByMaid) {

          var latitude = double.parse(user.latitude);
          var longitude = double.parse(user.longitude);
          // var image = ApiService.IMAGE_URL+maid.avatar;
          // BitmapDescriptor maidIcon = await createBitmapDescriptorFromAsset(maid.avatar);
          // print("maidIcon -------  ${maidIcon}");
          LatLng location = LatLng(latitude, longitude);
          final markerIcon = await _getMarkerIconFromUrl(ApiService.imageURL+user.avatar,'assets/images/marker.png', 125);
          log("marker -- image  -- ${ApiService.imageURL+user.avatar}");
          markers.add(
            Marker(
              markerId: MarkerId(user.id.toString()),
              position: location,
              icon: markerIcon,
              infoWindow: InfoWindow(
                title: user.cleanerName,
                snippet: user.address,
              ),
            ),
          );
        }

        update();
        isLoading(false);
      } else {
        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  // Future<BitmapDescriptor> _getMarkerIconFromUrl(String url, int size) async {
  //   final response = await http.get(Uri.parse(url));
  //   final codec = await ui.instantiateImageCodec(response.bodyBytes, targetWidth: size);
  //   final frameInfo = await codec.getNextFrame();
  //   final image = frameInfo.image;
  //
  //   final circleImage = await _createCircularImage(image, size);
  //   final byteData = await circleImage.toByteData(format: ui.ImageByteFormat.png);
  //   final uint8List = byteData!.buffer.asUint8List();
  //
  //   return BitmapDescriptor.fromBytes(uint8List);
  // }
  // Future<ui.Image> _createCircularImage(ui.Image image, int size) async {
  //   final pictureRecorder = ui.PictureRecorder();
  //   final canvas = Canvas(pictureRecorder);
  //   final paint = Paint()..isAntiAlias = true;
  //
  //   final clipPath = Path()
  //     ..addOval(Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()));
  //
  //   canvas.clipPath(clipPath);
  //   canvas.drawImageRect(
  //     image,
  //     Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
  //     Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
  //     paint,
  //   );
  //
  //   final picture = pictureRecorder.endRecording();
  //   return picture.toImage(size, size);
  // }

  Future<BitmapDescriptor> _getMarkerIconFromUrl(String url, String assetPath, int size) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final codec = await ui.instantiateImageCodec(response.bodyBytes, targetWidth: size);
        final frameInfo = await codec.getNextFrame();
        final image = frameInfo.image;

        final combinedImage = await _createCombinedImage(image, assetPath, size);
        final byteData = await combinedImage.toByteData(format: ui.ImageByteFormat.png);
        final uint8List = byteData!.buffer.asUint8List();

        return BitmapDescriptor.fromBytes(uint8List);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception('Failed to create marker icon: $e');
    }
  }

  Future<ui.Image> _createCombinedImage(ui.Image userImage, String assetPath, int size) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint()..isAntiAlias = true;

    final clipPath = Path()
      ..addOval(Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()));

    canvas.clipPath(clipPath);

    // Draw the asset image
    final assetData = await rootBundle.load(assetPath);
    final assetBytes = assetData.buffer.asUint8List();
    final codecAsset = await ui.instantiateImageCodec(assetBytes, targetWidth: size);
    final frameInfoAsset = await codecAsset.getNextFrame();
    final assetImage = frameInfoAsset.image;

    canvas.drawImageRect(
      assetImage,
      Rect.fromLTWH(20, 0, assetImage.width.toDouble(), assetImage.height.toDouble()),
      Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      paint,
    );

    // Draw the user image on top
    canvas.drawImageRect(
      userImage,
      Rect.fromLTWH(0, 0, userImage.width.toDouble(), userImage.height.toDouble()),
      Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      paint,
    );

    final picture = pictureRecorder.endRecording();
    return picture.toImage(size, size);
  }





  var isFavorite = <String, bool>{}.obs; // Maintain favorite status per item



  Future<void> toggleFavorite(String id) async {
    // Update the UI immediately
    isFavorite[id] = !isFavorite[id]!;
    update();

    try {
      isLoadingFavUnfav(true);
      var response = await ApiService().favoriteUnfavoriteApi(id);

      if (response['status'] == true) {
        //       await Recommended_List_Api();
      }
    } finally {
      isLoadingFavUnfav(false);
    }
  }



  // Future Faviourite_Unfaviourite(cleaner_co_host_id) async {
  //   try {
  //     // isLoading(true);
  //
  //     var response = await ApiService().Favorite_Unfavorite(cleaner_co_host_id);
  //
  //     if (response['status'] == true) {
  //
  //       // Near_by_Maid_Api();
  //       update();
  //       // isLoading(false);
  //     } else if (response['status'] == false) {
  //
  //
  //       // isLoading(false);
  //       update();
  //     }
  //   } finally {
  //     // isLoading(false);
  //     update();
  //   }
  // }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
