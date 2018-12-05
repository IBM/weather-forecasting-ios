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

struct CurrentCondition: Decodable {
    var metadata: Metadata?
    var observation: Observation?

    var currentIcon: Int {
        return observation?.wxIcon ?? 44
    }

    var currentTemperature: String {
        return unwrap(observation?.temp)
    }

    var bluntPhrase: String {
        return unwrap(observation?.bluntPhrase)
    }

    var feelsLike: String {
        return unwrap(observation?.feelsLike)
    }

    var humidity: String {
        return unwrap(observation?.rh)
    }

    var wind: String {
        return unwrap(observation?.wspd)
    }

    var windDir: String {
        return unwrap(observation?.wdirCardinal)
    }

    private func unwrap(_ field: CustomStringConvertible?) -> String {
        if let field = field {
            return "\(field)"
        }
        return "--"
    }
}
