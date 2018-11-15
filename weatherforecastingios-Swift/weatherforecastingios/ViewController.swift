/**
 * Copyright IBM Corporation 2016,2017,2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import UIKit
import MapKit
import QuartzCore
import BMSCore







class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // Apple maps view
    @IBOutlet weak var mapView: MKMapView!

    // Logging for the view controller
    let logger = Logger.logger(name: "ViewController")

    // The radius for the region when the map zooms up
    let regionRadius: CLLocationDistance = 8000

    // Used to get the current location
    let locationManager = CLLocationManager()

    // Activity indicator View
    var activityIndicatorView: UIView?

    // View Model for weather data
    var viewModel: WeatherViewModel?

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add the long press action to the map view
        let longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                               action: #selector(self.longPress(recognizer:)))
        mapView.addGestureRecognizer(longPressRecognizer)
        mapView.delegate = self

        // Register observer
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didBecomeActive),
                                               name: .UIApplicationDidBecomeActive,
                                               object: nil)

        // Setup location services
        self.setupLocationServices()

        // Setup Weather Credentials
        self.setupCredentials()

        
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // If the app becomes active, send analytics data to the Mobile Analytics service
    @objc func didBecomeActive(notification: NSNotification) {
        
        
    }

    // On callout tapped, show the 10 day forecast on the screen
    @objc func calloutTapped(recognizer: UITapGestureRecognizer?) {
        // Perform 10 day segue closure
        let performTenDaySegue = {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "tenDay", sender: nil)
            }
        }

        // If we have data available, perform the segue
        if viewModel?.tenDayForecast != nil {
            performTenDaySegue()
            return
        }

        // Otherwise, retrieve the coodinate
        let coordinate = self.mapView.annotations[0].coordinate

        // Retrieve the daily forecast and perform the segue
        viewModel?.getDailyForecast(coordinate) {
            performTenDaySegue()
        }
    }

    // Gets the data from the Weather service and sets a pin on each long press
    @objc func longPress(recognizer: UILongPressGestureRecognizer?) {
        if recognizer?.state == .began, let touchPoint = recognizer?.location(in: self.mapView) {

            let location = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)

            guard let vm = viewModel else {
                self.showAlert(NetworkingError.missingCredentials)
                return
            }

            // Retrieve weather data for the new location
            vm.getWeatherData(coordinate: location) { result in

                if result, let data = vm.weatherData {
                    /// Add the new annotation to the map and select it
                    DispatchQueue.main.async {
                        self.mapView.addAnnotation(data)
                        self.mapView.selectAnnotation(data, animated: true)
                        self.hideActivityIndicator()
                    }

                } else {
                    self.showAlert(WeatherRetrievalError.weather)
                }
            }

            // Remove the old weather annotation
            mapView.removeAnnotations(mapView.annotations)

            /// Start activity indicator
            showActivityIndicator()
        }
    }

    // Method to show the activity indicator
    func showActivityIndicator() {
        guard let view = self.view else {
            return
        }

        // Create our activity view container
        let container: UIView = UIView()
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)

        // Create our UIActivityIndicatorView
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.center = container.center
        actInd.color = UIColor.black

        // Add the activity indicator to our container
        container.addSubview(actInd)

        // Add the container to the ViewController's view
        view.addSubview(container)

        // Begin Animating
        actInd.startAnimating()
        self.activityIndicatorView = container
    }

    // Method to hide the activity indicator
    func hideActivityIndicator() {
        self.activityIndicatorView?.removeFromSuperview()
        self.activityIndicatorView = nil
    }

    // Prepare for segue override
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// Add the 10 day forecast to the Forecast TableViewController
        if let destination = segue.destination as? Forecast {
            destination.forecast = viewModel?.tenDayForecast
        }
    }
}

// Mark - MapView Customization

extension ViewController {

    // Helper function to center the map on a current location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    // Gets the current location using the coordinates from your device's location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()

        let currentLocation: CLLocation = manager.location!
        self.centerMapOnLocation(location: currentLocation)

    }

    // Method to provide annotation view pin when map location is selected
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? PinAnnotationView {
            dequeuedView.annotation = annotation
            return dequeuedView
        } else {
            return PinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
    }

    // Handler to add weather view details when annotation view's pin is selected
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Cast to WeatherAnnotation
        guard let weatherAnnotation = view.annotation as? WeatherAnnotation else {
            self.logger.error(message: "Unexpected annotation type")
            return
        }

        guard let calloutView = viewModel?.getWeatherAnnotationView(weatherAnnotation) else {
            self.logger.error(message: "Weather Service credentials were incorrect")
            return
        }

        let latitude = weatherAnnotation.coordinate.latitude
        let longitude = weatherAnnotation.coordinate.longitude
        centerMapOnLocation(location: CLLocation(latitude: latitude, longitude: longitude))

        let calloutTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.calloutTapped(recognizer:)))
        calloutView.addGestureRecognizer(calloutTapRecognizer)

        view.addSubview(calloutView)
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.5)
    }
}

// Mark - Setup and Utility functions

extension ViewController {

    // Function to show an alert with an alertTitle String and alertMessage String
    fileprivate func showAlert(_ error: WeatherError) {
        // Remove activity indicator
        DispatchQueue.main.async {
            self.hideActivityIndicator()
        }
        // Log error
        logger.error(message: error.description)
        // If an alert is not currently being displayed
        if self.presentedViewController == nil {
            // Set alert properties
            let alert = UIAlertController(title: "Weather Failed", message: error.description, preferredStyle: UIAlertControllerStyle.alert)
            // Add an action to the alert
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            // Show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }

    /// Request authorization for location services and center map
    fileprivate func setupLocationServices() {
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        // If location services are enabled, set the current location and update location
        // If location services are disabled, default to Austin
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            let initialLocation = CLLocation(latitude: 30.266620, longitude: -97.758066)
            self.centerMapOnLocation(location: initialLocation)
        }
    }

    // Set the credentials from the BMSCredentials.plist file, this will be created for you if the
    // Weather service is added to you iOS Project
    fileprivate func setupCredentials() {
        guard let path = Bundle.main.path(forResource: "BMSCredentials", ofType: "plist"),
            let credentials = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {

                self.showAlert(NetworkingError.missingCredentials)
                return
        }

        guard let username = credentials["weatherinsightsUsername"] as? String, !username.isEmpty,
            let password = credentials["weatherinsightsPassword"] as? String, !password.isEmpty,
            let host = credentials["weatherinsightsHost"] as? String , !host.isEmpty else {

                self.showAlert(NetworkingError.missingCredentials)
                return
        }

        let creds = WeatherCredentials(username: username, password: password, host: host)
        self.viewModel = WeatherViewModel(credentials: creds)
    }
}


