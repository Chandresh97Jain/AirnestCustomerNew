import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'google_map_and_places.dart' as local_maps;

class GoogleMapServiceController extends GetxController {
  final String kGoogleApiKey = "AIzaSyBgK_YgWu8pUK2OvDEFTYm9FUy7osv2Peg";
  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: "");
  final uuid =  const Uuid();
  String sessionToken = const Uuid().v4();
  var addressController = ReactiveTextEditingController().obs;
  var placesList = <PlaceAutocompletePrediction>[].obs;
  var selectedPlaceDetails = local_maps.PlaceDetails(
    geometry: local_maps.Geometry(
      location: local_maps.Location(lat: 0, lng: 0),
    ),
  ).obs;

  // late GoogleMapController mapController;
  final loc.Location locationService = loc.Location();
  LatLng? currentLocation;
  final currentAddress = ValueNotifier<String>("");
  final latitude = ''.obs;
  final longitude = ''.obs;
  final isLoading = false.obs;
  final focusNode = FocusNode().obs;
  final isFocused = false.obs;

  @override
  void onInit() {
    super.onInit();
    focusNode.value.addListener(() {
      isFocused.value = focusNode.value.hasFocus;
    });
    // getCurrentLocation();
  }

  @override
  void onClose() {
    focusNode.value.dispose();
    super.onClose();
    addressController.value.clear();
  }

  @override
  void dispose() {
    focusNode.value.dispose();
    super.dispose();
  }

  void onChanged(String value) {
    if (sessionToken == null) {
      sessionToken = uuid.v4();
    }
    googlePlacesApi(value);
  }

  Future<void> googlePlacesApi(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kGoogleApiKey';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      placesList.value =
          PlaceAutocompleteResponse.fromJson(json.decode(response.body))
              .predictions;
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      addressController.value.clear();
      isLoading(true);
      var location = await locationService.getLocation();
      currentLocation = LatLng(location.latitude!, location.longitude!);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude!,
        location.longitude!,
      );
      Placemark place = placemarks[0];

      currentAddress.value =
          "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      addressController.value.text =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
      latitude.value = location.latitude.toString();
      longitude.value = location.longitude.toString();

      // if (mapController != null) {
      //   mapController.animateCamera(CameraUpdate.newCameraPosition(
      //     CameraPosition(target: currentLocation!, zoom: 15),
      //   ));
      // }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      currentLocation = null;
      print("Error getting location: $e");
    }
  }

  Future<void> getPlaceDetails(String placeId) async {

    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request =
        '$baseURL?place_id=$placeId&key=$kGoogleApiKey&sessiontoken=$sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      selectedPlaceDetails.value =
          PlaceDetailsResponse.fromJson(json.decode(response.body)).result;

      latitude.value =
          selectedPlaceDetails.value.geometry.location.lat.toString();
      longitude.value =
          selectedPlaceDetails.value.geometry.location.lng.toString();
    } else {
      throw Exception('Failed to load place details');
    }
  }

  String street = '';
  String city = '';
  String state = '';
  String zipCode = '';

  // Replace with your Google Places API key
  final String apiKey = 'AIzaSyBgK_YgWu8pUK2OvDEFTYm9FUy7osv2Peg';
  Future<void> fetchPlaceDetails() async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJ_1oyZaZZwokR1c-HIVJ3xzo&key=$kGoogleApiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final addressComponents = data['result']['address_components'];

      for (final component in addressComponents) {
        final types = List<String>.from(component['types']);

        if (types.contains('street_number') || types.contains('route')) {
          street = component['long_name'];
        } else if (types.contains('locality')) {
          city = component['long_name'];
        } else if (types.contains('administrative_area_level_1')) {
          state = component['short_name'];
        } else if (types.contains('postal_code')) {
          zipCode = component['long_name'];
        }
      }

      print(
          "street - $street, city - $city, state - $state, zipCode - $zipCode");
    } else {
      throw Exception('Failed to load place details');
    }
  }
}

class ReactiveTextEditingController extends TextEditingController {
  final RxString textRx;

  ReactiveTextEditingController({String? text})
      : textRx = (text ?? '').obs,
        super(text: text);

  @override
  set text(String newText) {
    textRx.value = newText;
    super.text = newText;
  }
}

// class GoogleMapServices{
//
//   final kGoogleApiKey = "AIzaSyBgK_YgWu8pUK2OvDEFTYm9FUy7osv2Peg";
//   GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: "");
//   final uuid = Uuid();
//   String sessionToken = Uuid().v4();
//   final  addressController = TextEditingController().obs;
//   var placesList = <PlaceAutocompletePrediction>[].obs;
//   var selectedPlaceDetails = local_maps.PlaceDetails(geometry: local_maps.Geometry(location: local_maps.Location(lat: 0, lng: 0))).obs;
//
//   late GoogleMapController mapController;
//   final loc.Location locationService = loc.Location();
//   LatLng? currentLocation;
//   final currentAddress = ValueNotifier<String>("");
//   final latitude = ''.obs;
//   final longitude =''.obs;
//
//   onChanged(value) {
//     if (sessionToken == null) {
//       sessionToken = uuid.v4();
//     }
//     googlePlacesApi(value);
//   }
//   googlePlacesApi(String input) async {
//     https://maps.googleapis.com/maps/api/place/autocomplete/json?input=&key=AIzaSyBgK_YgWu8pUK2OvDEFTYm9FUy7osv2Peg
//     String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String type = '(regions)';
//     // String request = '$baseURL?input=$input&key=$kGoogleApiKey&sessiontoken=$sessionToken&type=$type';
//     String request = '$baseURL?input=$input&key=$kGoogleApiKey';
//     var response = await http.get(Uri.parse(request));
//     if (response.statusCode == 200) {
//       placesList.value = PlaceAutocompleteResponse.fromJson(json.decode(response.body)).predictions;
//     } else {
//       throw Exception('Failed to load predictions');
//     }
//   }
//   getCurrentLocation() async {
//     try {
//       // loading = true;
//       var location = await locationService.getLocation();
//       currentLocation = LatLng(location.latitude!, location.longitude!);
//
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//           location.latitude!, location.longitude!);
//       Placemark place = placemarks[0];
//
//
//       currentAddress.value = "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//       addressController.value.text = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
//       // addressController.text = "Address: $fullAddress\nLatitude: ${location.latitude}\nLongitude: ${location.longitude}";
//       latitude.value = location.latitude.toString();
//       longitude.value = location.longitude.toString();
//       print("When i get current location - --👇🏻");
//       print("Latitude: ${latitude.value},"
//           " Longitude: ${longitude.value}");
//
//       // loading = false;
//
//       // if (mapController != null) {
//       //   mapController.animateCamera(CameraUpdate.newCameraPosition(
//       //     CameraPosition(target: currentLocation!, zoom: 15),
//       //   ));
//       // }
//     } catch (e) {
//       // loading = false;
//       currentLocation = null;
//     }
//     // loading = false;
//   }
//   getPlaceDetails(String placeId) async {
//     String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
//     String request = '$baseURL?place_id=$placeId&key=$kGoogleApiKey&sessiontoken=$sessionToken';
//     var response = await http.get(Uri.parse(request));
//     if (response.statusCode == 200) {
//       selectedPlaceDetails.value = PlaceDetailsResponse.fromJson(json.decode(response.body)).result;
//
//       latitude.value = selectedPlaceDetails.value.geometry.location.lat.toString();
//       longitude.value = selectedPlaceDetails.value.geometry.location.lng.toString();
//       print("When i pick location - --👇🏻");
//       print("Latitude: ${selectedPlaceDetails.value.geometry.location.lat},"
//           " Longitude: ${selectedPlaceDetails.value.geometry.location.lng}");
//     } else {
//       throw Exception('Failed to load place details');
//     }
//   }
//
//
//   String street = '';
//   String city = '';
//   String state = '';
//   String zipCode = '';
//
//   // Replace with your Google Places API key
//   final String apiKey = 'AIzaSyBgK_YgWu8pUK2OvDEFTYm9FUy7osv2Peg';
//   Future<void> fetchPlaceDetails() async {
//     final url =
//         'https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJ_1oyZaZZwokR1c-HIVJ3xzo&key=$apiKey';
//
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//
//       final addressComponents = data['result']['address_components'];
//
//       for (final component in addressComponents) {
//         final types = List<String>.from(component['types']);
//
//         if (types.contains('street_number') || types.contains('route')) {
//           street = component['long_name'];
//         } else if (types.contains('locality')) {
//           city = component['long_name'];
//         } else if (types.contains('administrative_area_level_1')) {
//           state = component['short_name'];
//         } else if (types.contains('postal_code')) {
//           zipCode = component['long_name'];
//         }
//       }
//
//       print( "street - $street, city - $city, state - $state, zipCode - $zipCode ");
//
//     } else {
//       throw Exception('Failed to load place details');
//     }
//   }
//
// }

class Prediction {
  final String description;
  final String placeId;

  Prediction({required this.description, required this.placeId});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}

class PlaceAutocompleteResponse {
  final List<PlaceAutocompletePrediction> predictions;

  PlaceAutocompleteResponse({required this.predictions});

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutocompleteResponse(
      predictions: (json['predictions'] as List)
          .map((e) => PlaceAutocompletePrediction.fromJson(e))
          .toList(),
    );
  }
}

class PlaceAutocompletePrediction {
  final String description;
  final String placeId;

  PlaceAutocompletePrediction(
      {required this.description, required this.placeId});

  factory PlaceAutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return PlaceAutocompletePrediction(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}

class PlaceDetailsResponse {
  final local_maps.PlaceDetails result;

  PlaceDetailsResponse({required this.result});

  factory PlaceDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsResponse(
      result: local_maps.PlaceDetails.fromJson(json['result']),
    );
  }
}

class PlaceDetails {
  final Geometry geometry;

  PlaceDetails({required this.geometry});

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    return PlaceDetails(
      geometry: Geometry.fromJson(json['geometry']),
    );
  }
}

class Geometry {
  final Location location;

  Geometry({required this.location});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
