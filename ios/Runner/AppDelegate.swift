import UIKit
import Flutter
import GoogleMaps
import FBSDKCoreKit
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate,CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyBgK_YgWu8pUK2OvDEFTYm9FUy7osv2Peg")
    GeneratedPluginRegistrant.register(with: self)
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
          // Permission not yet requested
          break
        case .restricted, .denied:
          // Permission denied, handle accordingly
          break
        case .authorizedWhenInUse, .authorizedAlways:
          // Permission granted, you can start updating location
          manager.startUpdatingLocation()
        @unknown default:
          // Handle other possible cases
          break
        }
      }
}
