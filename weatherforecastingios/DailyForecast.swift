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

struct DailyForecast: Decodable {
    var metadata: Metadata?
    var forecasts: [ForecastDaily]?
}

extension DailyForecast {

    var daily: Daily? {
        return forecasts?[0].day ?? forecasts?[0].night!
    }

    var today: String {
        return unwrap(daily?.daypartName)
    }

    var dayOne: String {
        return unwrap(forecasts?[1].dow)
    }

    var dayTwo: String {
        return unwrap(forecasts?[2].dow)
    }

    var dayThree: String {
        return unwrap(forecasts?[3].dow)
    }

    var narrative: String {
        return unwrap(daily?.narrative)
    }

    var iconOne: Int {
        return forecasts?[1].day?.iconCode ?? 44
    }

    var iconTwo: Int {
        return forecasts?[2].day?.iconCode ?? 44
    }

    var iconThree: Int {
        return forecasts?[3].day?.iconCode ?? 44
    }

    var maxOne: String {
        return unwrap(forecasts?[1].maxTemp)
    }

    var minOne: String {
        return unwrap(forecasts?[1].minTemp)
    }

    var maxTwo: String {
        return unwrap(forecasts?[2].maxTemp)
    }

    var minTwo: String {
        return unwrap(forecasts?[2].minTemp)
    }

    var maxThree: String {
        return unwrap(forecasts?[3].maxTemp)
    }

    var minThree: String {
        return unwrap(forecasts?[3].minTemp)
    }
    
    private func unwrap(_ field: CustomStringConvertible?) -> String {
        if let field = field {
            return "\(field)"
        }
        return "--"
    }
}
