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

import Foundation
import ObjectMapper

open class Metadata: Mappable {
    // The version number of the API
    var version: String?
    // Transaction ID for this call of the API
    var transactionId: String?
    // The data expiration time in UNIX seconds
    var expireTimeGmt: Double?
    // An echo parameter that displays the requested postal code for a location's forecast
    var locationId: String?
    // An echo parameter that displays the requested country code for a location's forecast
    var countrycode: String?
    // An echo parameter that displays the requested latitude for a location's forecast
    var latitude: Float?
    // An echo parameter that displays the requested latitude for a location’s forecast
    var longitude: Float?
    // An echo parameter that displays the default or requested translation language for response text
    var language: String?
    // An echo parameter that displays the default or requested units of measure (UOM) for various numeric values
    var units: String?

    required public init?(map: Map) {

    }

    open func mapping(map: Map) {
        version <- map["version"]
        transactionId <- map["transaction_id"]
        expireTimeGmt <- map["expire_time_gmt"]
        locationId <- map["location_id"]
        countrycode <- map["countrycode"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        language <- map["language"]
        units <- map["units"]
    }
}
