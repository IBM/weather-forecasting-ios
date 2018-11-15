/*
 *     Copyright 2016, 2017 IBM Corp.
 *     Licensed under the Apache License, Version 2.0 (the "License");
 *     you may not use this file except in compliance with the License.
 *     You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 *     Unless required by applicable law or agreed to in writing, software
 *     distributed under the License is distributed on an "AS IS" BASIS,
 *     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *     See the License for the specific language governing permissions and
 *     limitations under the License.
 */

import UIKit
import MapKit
import ObjectMapper
import BMSCore

class WeatherData: NSObject, MKAnnotation {
    let logger = Logger.logger(name: "WeatherData")

    // Current observation values
    var currentIcon = 44
    var location = "Location Unknown"
    var currentTemperature = "--"
    var bluntPhrase = ""
    var feelsLike = "--"
    var humidity = "--"
    var wind = "--"
    var windDir = "--"

    // Forecast values
    var today = "--"
    var narrative = ""
    var dayOne = "--"
    var dayTwo = "--"
    var dayThree = "--"
    var iconOne = 44
    var iconTwo = 44
    var iconThree = 44
    var maxOne = "--"
    var maxTwo  = "--"
    var maxThree = "--"
    var minOne = "--"
    var minTwo = "--"
    var minThree = "--"

    // WeatherData object values
    var title: String?
    let coordinate: CLLocationCoordinate2D
    let username: String
    let password: String
    let host: String

    // WeatherData object initialization
    init(title: String, coordinate: CLLocationCoordinate2D, username: String, password: String, host: String) {
        self.title = title
        self.coordinate = coordinate
        self.username = username
        self.password = password
        self.host = host
    }

    // Get the location name, current conditions, and three day forecast
    // After all of these values are updated, I update the UI
    func getData(completion: @escaping (Bool) -> ()) {
        self.getLocationName(completion: {(result: Bool) -> Void in
            if result == true {
                self.getCurrentConditions(completion: {(result: Bool) -> Void in
                    if result == true {
                        self.getThreeDayForecast(completion: {(result: Bool) -> Void in
                            if result == true {
                                completion(true)
                            }
                            else {
                                self.logger.error(message: "Failed to get three day forecast")
                                completion(false)
                            }
                        })

                    }
                    else {
                        self.logger.error(message: "Failed to get current conditions")
                        completion(false)
                    }
                })

            }
            else {
                self.logger.error(message: "Failed to get location name")
                completion(false)
            }
        })
    }

    // Get the current conditions from the Weather service
    func getCurrentConditions(completion: @escaping (Bool) -> ()) {
        let latitude = coordinate.latitude.description
        let longitude = coordinate.longitude.description
        let url = "https://" + host + "/api/weather/v1/geocode/\(latitude)/\(longitude)/observations.json"
        let basicAuth = "Basic " + "\(username):\(password)".toBase64()
        let headers = ["Authorization" : basicAuth]

        let request = Request(url: url,
                              method: .GET,
                              headers: headers)

        request.send { (response, error) in
            if let error = error {
                self.logger.error(message: "error :: \(error)")
                return
            }
            guard let response = response else {
                return
            }
            if response.isSuccessful {
                let text = response.responseText
                let currentConditions = Mapper<CurrentCondition>().map(JSONString: text!);
                self.title = currentConditions!.metadata!.transactionId
                let observation = currentConditions!.observation!
                self.currentIcon = observation.wxIcon ?? self.currentIcon
                self.currentTemperature = (observation.temp != nil) ? "\(observation.temp!)" : self.currentTemperature
                self.bluntPhrase = observation.bluntPhrase ?? self.bluntPhrase
                self.feelsLike = (observation.feelsLike != nil) ? "\(observation.feelsLike!)" : self.feelsLike
                self.humidity = (observation.rh != nil) ? "\(observation.rh!)" : self.humidity
                self.wind = (observation.wspd != nil) ? "\(observation.wspd!)" : self.wind
                self.windDir = observation.wdirCardinal ?? self.windDir

                completion(true)

            } else {
                if response.statusCode! == 401 {
                    self.logger.error(message: "Failed to connect to the Weather Company Data service due to invalid credentials. Please verify your credentials in the WeatherCredentials.plist file and rebuild the application. See the README for further assistance.")
                } else {
                    self.logger.error(message: "Failed Request to Weather Service :: Status: \(String(describing: response.statusCode)), Message: \(response.responseText!)")
                }

                completion(false)
            }
        }
    }

    // Get the three day forecast from the Weather service
    func getThreeDayForecast(completion: @escaping (Bool) -> ()) {
        let latitude = coordinate.latitude.description
        let longitude = coordinate.longitude.description
        let url = "https://" + host + "/api/weather/v1/geocode/\(latitude)/\(longitude)/forecast/daily/3day.json"
        let basicAuth = "Basic " + "\(username):\(password)".toBase64()
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
                let threeDay = Mapper<DailyForecast>().map(JSONString: text!);
                let forecasts = threeDay!.forecasts!
                let daily = forecasts[0].day ?? forecasts[0].night!
                self.today = daily.daypartName ?? self.today
                self.narrative = daily.narrative ?? self.narrative

                self.dayOne = forecasts[1].dow ?? self.dayOne
                self.dayTwo = forecasts[2].dow ?? self.dayTwo
                self.dayThree = forecasts[3].dow ?? self.dayThree

                self.iconOne = forecasts[1].day!.iconCode ?? self.iconOne
                self.iconTwo = forecasts[2].day!.iconCode ?? self.iconTwo
                self.iconThree = forecasts[3].day!.iconCode ?? self.iconThree

                self.maxOne = (forecasts[1].maxTemp != nil) ? "\(forecasts[1].maxTemp!)" : self.maxOne
                self.minOne = (forecasts[1].minTemp != nil) ? "\(forecasts[1].minTemp!)" : self.minOne
                self.maxTwo = (forecasts[2].maxTemp != nil) ? "\(forecasts[2].maxTemp!)" : self.maxTwo
                self.minTwo = (forecasts[2].minTemp != nil) ? "\(forecasts[2].minTemp!)" : self.minTwo
                self.maxThree = (forecasts[3].maxTemp != nil) ? "\(forecasts[3].maxTemp!)" : self.maxThree
                self.minThree = (forecasts[3].minTemp != nil) ? "\(forecasts[3].minTemp!)" : self.minThree

                completion(true)
            } else {
                if response.statusCode! == 401 {
                    self.logger.error(message: "Failed to connect to the Weather Company Data service due to invalid credentials. Please verify your credentials in the WeatherCredentials.plist file and rebuild the application. See the README for further assistance.")

                } else {
                    self.logger.error(message: "Failed Request to Weather Service :: Status: \(String(describing: response.statusCode)), Message: \(response.responseText!)")
                }
                completion(false)
            }
        }
    }

    // Get the location name from the Geocode lookup
    func getLocationName(completion: @escaping (Bool) -> ()) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                self.logger.error(message: "Error received searching for location name from coordinates: \(error)")
                completion(false)
            } else {
                var placemark: CLPlacemark!
                placemark = placemarks?[0]

                if let city = placemark.addressDictionary!["City"] as! String? {
                    self.location = city;
                } else if let name = placemark.addressDictionary!["Name"] as! String? {
                    self.location = name;
                }
                completion(true);
            }
        }
    }
}
