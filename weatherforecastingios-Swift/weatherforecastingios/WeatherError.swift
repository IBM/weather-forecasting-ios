/**
 * Copyright IBM Corporation 2018
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

// Error Protocol
protocol WeatherError: Error, CustomStringConvertible {
}

// Enum describing weather data errors
enum WeatherRetrievalError: WeatherError {

    case locationName

    case currentConditions

    case threeDayForcast

    case weather

    var description: String {
        switch self {
        case .locationName: return "Could not retrieve location name"
        case .currentConditions: return "Could not retrieve current conditions"
        case .threeDayForcast: return "Could not retrieve three day forecast"
        case .weather: return "Could not retrieve data from the weather service"
        }
    }
}

// Enum describing networking and parsing errors
enum NetworkingError: WeatherError {

    case jsonDecoding

    case invalidCredentials

    case missingCredentials

    case failedRequest(Int?, String)

    case error(Error)

    case missingResponse

    var description: String {
        switch self {
        case .jsonDecoding:
            return "Could not decode json"
        case .invalidCredentials:
            return "Failed to connect to the Weather Company Data service due to invalid credentials. Please verify your credentials in the BMSCredentials.plist file and rebuild the application. See the README for further assistance."
        case .missingCredentials:
            return "Cannot connect to the Weather service due to missing credentials"
        case .failedRequest(let code, let msg):
            return "Failed Request to Weather Service :: Code \(String(describing: code)) | error \(msg)"
        case .error(let error):
            return "Error: \(error.localizedDescription)"
        case .missingResponse:
            return "No response was returned"
        }
    }
}
