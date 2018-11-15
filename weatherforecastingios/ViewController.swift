/*
 *     Copyright 2016, 2017 IBM Corp.
 *     Licensed under the Apache License, Version 2.0 (the "License");
 *     you may not use this file except in compliance with the License.
 *     You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 *     Unless required by applicable law or agreed to in writing, software
 *     distributed under the License is distributed on an "AS IS" BASIS,
 *     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *     See the License for the specific language governing permissions and
 *     limitations under the License.
 */

import UIKit
import MapKit
import ObjectMapper
import QuartzCore
import BMSCore




class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // Logging for the view controller
    let logger = Logger.logger(name: "ViewController")

    // Apple maps view
    @IBOutlet weak var mapView: MKMapView!

    // The radius for the region when the map zooms up
    let regionRadius: CLLocationDistance = 8000

    // Used to get the current location
    let locationManager = CLLocationManager()

    // Used to create a Weather object
    var tenDayForecast: DailyForecast?
    var username: String?
    var password: String?
    var host: String?

    override func viewDidLoad() {
        
        
        

        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(recognizer:)))

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

        // Add the long press action to the map view
        mapView.addGestureRecognizer(longPressRecognizer);
        mapView.delegate = self

        self.setCredentials()

        super.viewDidLoad()
    }

    // Set the credentials from the WeatherCredentials.plist file
    private func setCredentials() {
        if let path = Bundle.main.path(forResource: "WeatherCredentials", ofType: "plist"), let credentials = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            if let username = credentials["username"] as! String? , !username.isEmpty {
                self.username = username
            }
            if let password = credentials["password"] as! String? , !password.isEmpty {
                self.password = password
            }
            if let host = credentials["host"] as! String? , !host.isEmpty {
                self.host = host
            }
        }
    }

    // If the app becomes active, send analytics data to the Mobile Analytics service
    func didBecomeActive(notification: NSNotification) {
        
        
    }

    // Helper function to center the map on a current location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view: PinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? PinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = PinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        return view
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let weatherAnnotation = view.annotation as! WeatherData
        let views = Bundle.main.loadNibNamed("callout", owner: nil, options: nil)
        let calloutView = views?[0] as! CurrentConditionsCallout

        let latitude = view.annotation?.coordinate.latitude
        let longitude = view.annotation?.coordinate.longitude
        centerMapOnLocation(location: CLLocation(latitude: latitude!, longitude: longitude!))

        calloutView.layer.cornerRadius = 10
        calloutView.layer.masksToBounds = false
        calloutView.layer.shadowColor = UIColor.lightGray.cgColor
        calloutView.layer.shadowOpacity = 0.8
        calloutView.layer.shadowRadius = 3
        calloutView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)

        calloutView.currentIcon.image = UIImage(named: "\(weatherAnnotation.currentIcon)")

        if weatherAnnotation.location.characters.count > 20 {
            calloutView.location.font.withSize(10.0)
        }
        calloutView.location.text = weatherAnnotation.location

        calloutView.currentTemperature.text = "\(weatherAnnotation.currentTemperature)\u{00B0}"
        calloutView.bluntPhrase.text = weatherAnnotation.bluntPhrase
        calloutView.bluntPhrase.lineBreakMode = .byWordWrapping
        calloutView.bluntPhrase.numberOfLines = 0
        calloutView.feelsLike.text = "\(weatherAnnotation.feelsLike)\u{00B0}"
        calloutView.humidity.text = "\(weatherAnnotation.humidity)%"
        calloutView.wind.text = "\(weatherAnnotation.wind)mph \(weatherAnnotation.windDir)"

        calloutView.today.text = weatherAnnotation.today
        calloutView.narrative.text = weatherAnnotation.narrative
        calloutView.narrative.lineBreakMode = .byWordWrapping
        calloutView.narrative.numberOfLines = 0
        calloutView.dayOne.text = weatherAnnotation.dayOne
        calloutView.dayTwo.text = weatherAnnotation.dayTwo
        calloutView.dayThree.text = weatherAnnotation.dayThree
        calloutView.iconOne.image = UIImage(named: "\(weatherAnnotation.iconOne)")
        calloutView.iconTwo.image = UIImage(named: "\(weatherAnnotation.iconTwo)")
        calloutView.iconThree.image = UIImage(named: "\(weatherAnnotation.iconThree)")
        calloutView.tempOne.text = "\(weatherAnnotation.maxOne)\u{00B0} | \(weatherAnnotation.minOne)\u{00B0}"
        calloutView.tempTwo.text = "\(weatherAnnotation.maxTwo)\u{00B0} | \(weatherAnnotation.minTwo)\u{00B0}"
        calloutView.tempThree.text = "\(weatherAnnotation.maxThree)\u{00B0} | \(weatherAnnotation.minThree)\u{00B0}"

        let calloutTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.calloutTapped(recognizer:)))
        calloutView.addGestureRecognizer(calloutTapRecognizer);

        view.addSubview(calloutView)
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.5)
    }

    // On callout tapped, show the 10 day forecast on the screen
    func calloutTapped(recognizer: UITapGestureRecognizer?) {
        if let _ = tenDayForecast {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "tenDay", sender: nil)
            }

            return
        }
        let coordinate = self.mapView.annotations[0].coordinate
        let latitude = coordinate.latitude.description
        let longitude = coordinate.longitude.description
        let url = "https://" + host! + "/api/weather/v1/geocode/\(latitude)/\(longitude)/forecast/daily/10day.json"
        let basicAuth = "Basic " + "\(username!):\(password!)".toBase64()
        let headers = ["Authorization" : basicAuth]

        let request = Request(url: url,
                              method: .GET,
                              headers: headers)

        request.send { (response, error) in
            if let error = error {
                self.logger.error(message: "error :: \(error)")
            }
            guard let response = response else {
                return
            }
            if response.isSuccessful {

                let text = response.responseText
                self.tenDayForecast = Mapper<DailyForecast>().map(JSONString: text!)

                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "tenDay", sender: nil)
                }
            } else {
                if response.statusCode! == 401 {
                    self.logger.error(message: "Failed to connect to the Weather service due to invalid credentials")
                    self.showAlert("Weather Failed", alertMessage: "Failed to connect to the Weather Company Data service due to invalid credentials. Please verify your credentials in the WeatherCredentials.plist file and rebuild the application. See the README for further assistance.")
                } else {
                    self.logger.error(message: "Failed Request to Weather Service :: Status: \(String(describing: response.statusCode)), Message: \(response.responseText!)")
                }
            }
        }
    }

    // Gets the data from the Weather service and sets a pin on each long press
    func longPress(recognizer: UILongPressGestureRecognizer?) {
        if recognizer?.state == .began {
            guard let username = self.username, let password = self.password, let host = self.host else {
                self.logger.error(message: "Failed to connect to the Weather service due to invalid credentials")
                self.showAlert("Weather Failed", alertMessage: "Failed to connect to the Weather Company Data service due to invalid credentials. Please verify your credentials in the WeatherCredentials.plist file and rebuild the application. See the README for further assistance.")

                return
            }

            let touchPoint = recognizer?.location(in: self.mapView)
            let location = self.mapView.convert(touchPoint!, toCoordinateFrom: self.mapView)
            let weatherData = WeatherData(title: "This is a pin", coordinate: location, username: username, password: password, host: host)


            // Update view with location, current conditions, and three day forecast
            weatherData.getData(completion: {(result: Bool) -> Void in
                if result == true {
                    DispatchQueue.main.async {
                        self.mapView.deselectAnnotation(weatherData, animated: true)
                        self.mapView.addAnnotation(weatherData)
                        self.mapView.selectAnnotation(weatherData, animated: true)
                    }
                }
                else {
                    self.logger.error(message: "Failed getting data from Weather service")
                    self.showAlert("Weather Failed", alertMessage: "Failed to connect to the Weather Company Data service due to invalid credentials. Please verify your credentials in the WeatherCredentials.plist file and rebuild the application. See the README for further assistance.")
                }
            })

            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotation(weatherData)

            if let _ = tenDayForecast {
                tenDayForecast = nil
            }
            self.mapView.selectAnnotation(weatherData, animated: true)
        }
    }

    // Gets the current location using the coordinates from your device's location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()

        let currentLocation: CLLocation = manager.location!
        self.centerMapOnLocation(location: currentLocation)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! Forecast
        destination.forecast = tenDayForecast!
    }

    // Function to show an alert with an alertTitle String and alertMessage String
    func showAlert(_ alertTitle: String, alertMessage: String){
        if(self.presentedViewController == nil){
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
