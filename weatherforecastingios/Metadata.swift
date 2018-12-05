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

struct Metadata {
    // The version number of the API
    var version: String
    // Transaction ID for this call of the API
    var transactionId: String
    // The data expiration time in UNIX seconds
    var expireTimeGmt: Double
    // An echo parameter that displays the requested postal code for a location's forecast
    var locationId: String?
    // An echo parameter that displays the requested country code for a location's forecast
    var countrycode: String?
    // An echo parameter that displays the requested latitude for a location's forecast
    var latitude: Float
    // An echo parameter that displays the requested latitude for a location’s forecast
    var longitude: Float
    // An echo parameter that displays the default or requested translation language for response text
    var language: String
    // An echo parameter that displays the default or requested units of measure (UOM) for various numeric values
    var units: String?
}

// Mark - Decodable Conformance

// Can be automatically synthesized in Swift 4.1
extension Metadata: Decodable {

    enum CodingKeys: String, CodingKey {
        case version
        case transactionId = "transaction_id"
        case expireTimeGmt = "expire_time_gmt"
        case locationId = "location_id"
        case countrycode = "country_code"
        case latitude
        case longitude
        case language
        case units
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        version = try values.decode(String.self, forKey: .version)
        transactionId = try values.decode(String.self, forKey: .transactionId)
        expireTimeGmt = try values.decode(Double.self, forKey: .expireTimeGmt)
        locationId = try values.decodeIfPresent(String.self, forKey: .locationId)
        countrycode = try values.decodeIfPresent(String.self, forKey: .countrycode)
        latitude = try values.decode(Float.self, forKey: .latitude)
        longitude = try values.decode(Float.self, forKey: .longitude)
        language = try values.decode(String.self, forKey: .language)
        units = try values.decodeIfPresent(String.self, forKey: .units)
    }
}
