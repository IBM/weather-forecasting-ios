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

class WeatherAnnotation: NSObject, MKAnnotation {

    /// Annotation
    let coordinate: CLLocationCoordinate2D
    let title: String?

    /// Data
    let observation: CurrentCondition
    let forecast: DailyForecast

    init(title: String = "Location Unknown",
         coordinate: CLLocationCoordinate2D,
         observation: CurrentCondition,
         forecast: DailyForecast) {
        self.title = title
        self.coordinate = coordinate
        self.observation = observation
        self.forecast = forecast
    }
}
