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

import Foundation
import UIKit
import MapKit
import BMSCore

class WeatherViewModel {

    // Mark - public variables

    /// Ten Day Forecast
    var tenDayForecast: DailyForecast?

    /// Weather data for pin
    var weatherData: WeatherAnnotation?

    // Mark - private variables

    // Decoder
    fileprivate let decoder = JSONDecoder()

    // Logging for the view controller
    fileprivate let logger = Logger.logger(name: "ViewController")

    // Credentials
    fileprivate let credentials: WeatherCredentials

    init(credentials: WeatherCredentials) {
        self.credentials = credentials

        // JSON Formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-Z"
        decoder.dateDecodingStrategy = .formatted(formatter)

    }
}

// Mark - External Api

extension WeatherViewModel {

    // Create the weather annotation view
    func getWeatherAnnotationView(_ weatherAnnotation: WeatherAnnotation) -> UIView {
        let views = Bundle.main.loadNibNamed("callout", owner: nil, options: nil)

        // Ensure we are returned
        guard let calloutView = views?[0] as? CurrentConditionsCallout else {
            return UIView()
        }

        // Setup the view using our weather annotation data
        calloutView.setup(using: weatherAnnotation)

        return calloutView
    }

    // Retrieve the location name, current conditions, and three day forecast for the specified coordinate
    func getWeatherData(coordinate: CLLocationCoordinate2D, completion: @escaping (Bool) -> Void) {

        // Remove old data
        tenDayForecast = nil
        weatherData = nil

        let group = DispatchGroup()

        // Response Data
        var currentConditions: CurrentCondition!
        var threeDayForecast: DailyForecast!
        var location: String!
        var errors: [WeatherRetrievalError] = []

        // Retrieve the location name
        group.enter()
        self.getLocationName(coordinate) { result in
            process(result, output: &location, error: .locationName)
        }

        // Retrieve the current conditions
        group.enter()
        self.getCurrentConditions(coordinate) { result in
            process(result, output: &currentConditions, error: .currentConditions)
        }

        // Retrieve the current forecast
        group.enter()
        self.getThreeDayForecast(coordinate) { result in
            process(result, output: &threeDayForecast, error: .threeDayForcast)
        }

        func process<T>(_ result: Any?, output: inout T, error: WeatherRetrievalError) {
            defer { group.leave() }
            guard let result = result as? T else {
                errors.append(error)
                return
            }
            output = result
        }

        // Update our data, when all requests have returned
        group.notify(queue: .main) {
            if errors.count == 0 {
                self.weatherData = WeatherAnnotation(title: location,
                                                     coordinate: coordinate,
                                                     observation: currentConditions,
                                                     forecast: threeDayForecast)
            } else {
                errors.forEach { self.logger.error(message: $0.description) }
            }
            completion(errors.count == 0)
        }
    }

    /// Retrieve the daily forecast for a specified latitude and longitude
    func getDailyForecast(_ coordinate: CLLocationCoordinate2D, completion: @escaping () -> Void) {

        let url = baseURL(coordinate) + "/forecast/daily/10day.json"

        let request = Request(url: url, method: .GET, headers: credentials.basicAuth)

        let failure = { (err: NetworkingError) in
            self.logger.error(message: err.description)
        }

        sendRequest(request, failure: failure) { (dailyForecast: DailyForecast) in
            self.tenDayForecast = dailyForecast
            completion()
        }
    }

    // Retrieve the current conditions of the specified coordinate from the Weather service
    func getCurrentConditions(_ coordinate: CLLocationCoordinate2D, completion: @escaping (CurrentCondition?) -> Void) {

        let url = baseURL(coordinate) + "/observations.json"

        let request = Request(url: url, method: .GET, headers: credentials.basicAuth)

        let failure = { (err: NetworkingError) in
            self.logger.error(message: err.description)
            completion(nil)
        }

        sendRequest(request, failure: failure) { (currentConditions: CurrentCondition) in
            completion(currentConditions)
        }
    }

    // Retrieve the three day forecast for the specified coordinate from the Weather service
    func getThreeDayForecast(_ coordinate: CLLocationCoordinate2D, completion: @escaping (DailyForecast?) -> Void) {

        let url = baseURL(coordinate) + "/forecast/daily/3day.json"

        let request = Request(url: url, method: .GET, headers: credentials.basicAuth)

        let failure = { (err: NetworkingError) in
            self.logger.error(message: err.description)
            completion(nil)
        }

        sendRequest(request, failure: failure) { (threeDay: DailyForecast) in
            completion(threeDay)
        }
    }

    // Retrieve the location name of the specified coordinate from the Geocode lookup
    func getLocationName(_ coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        geoCoder.reverseGeocodeLocation(location) { placemarks, error in

            if let error = error {
                self.logger.error(message: NetworkingError.error(error).description)
                completion(nil)
                return
            }

            let placemark = placemarks?.first

            if let city = placemark?.subAdministrativeArea {
                completion(city)
            } else if let name = placemark?.name {
                completion(name)
            } else {
                completion("Location Unknown")
            }
        }
    }
}

// Mark - Utility Methods

extension WeatherViewModel {

    /// Networking Utility method to send and parse networking response
    fileprivate func sendRequest<T: Decodable>(_ req: Request, failure: @escaping (NetworkingError) -> Void, success: @escaping (T) -> Void) {

        req.send { response, error in
            if let error = error {
                return failure(.error(error))
            }

            guard let response = response else {
                return failure(.missingResponse)
            }

            guard response.isSuccessful, let data = response.responseData else {
                let err: NetworkingError = response.statusCode == 401 ? .jsonDecoding : .failedRequest(response.statusCode, response.responseText ?? "")
                return failure(err)
            }

            guard let decoded = try? self.decoder.decode(T.self, from: data) else {
                return failure(.jsonDecoding)
            }

            success(decoded)
        }
    }

    /// Method to create th ebase weather insights url for the given latittude and longitude
    fileprivate func baseURL(_ coordinate: CLLocationCoordinate2D) -> String {
        let latitude = coordinate.latitude.description
        let longitude = coordinate.longitude.description

        return credentials.baseURL + "\(latitude)/\(longitude)"
    }
}
