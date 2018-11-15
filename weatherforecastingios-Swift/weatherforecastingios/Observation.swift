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

open class Observation: Mappable {
    // Primary data field to group or access data for
    var key: String?
    // The data identifier
    var _class: String?
    // The absolute expiration time that is used to implement a common, system-wide method of data and cache expiration
    var expireTimeGmt: Double?
    // The ID of the observation station
    var obsId: String?
    // The name of the observation station
    var obsName: String?
    // The valid time of observation as a Unix epoch value (seconds since start of 1970, UTC)
    var validTimeGmt: Double?
    // The two-digit number to represent the observed weather conditions
    var wxIcon: Int?
    // The four-digit number to represent the observed weather conditions
    var iconExtd: Int?
    // The temperature of the air, measured by a thermometer 1.5 meters (4.5 feet) above the ground that is shaded from the other elements
    var temp: Int?
    // A text description of the observed weather conditions at the reporting station
    var wxPhrase: String?
    // A phrase describing the change in the barometric pressure reading over the last hour
    var pressureDesc: String?
    // The change in the barometric pressure reading over the last hour expressed as an integer
    var pressureTend: Int?
    // The cardinal direction from which the wind blows in an abbreviated form. Wind directions are always expressed as “from whence the wind blows” meaning that a North wind blows from North to South
    var wdirCardinal: String?
    // An indicator that indicates whether it is daytime or nighttime based on the local apparent time of the location
    var dayInd: String?
    // The maximum temperature in the last 24 hours
    var maxTemp: Int?
    // The minimum temperature in the last 24 hours
    var minTemp: Int?
    // The temperature that air must be cooled at constant pressure to reach saturation
    var dewpt: Int?
    // The relative humidity of the air, which is defined as the ratio of the amount of water vapor in the air to the amount of vapor required to bring the air to saturation at a constant temperature
    var rh: Int?
    // An apparent temperature that represents what the air temperature feels like on exposed human skin due to the combined effect of the wind chill or heat index
    var feelsLike: Int?
    // An apparent temperature that represents what the air temperature feels like on exposed human skin due to the combined effect of warm temperatures and high humidity
    var heatIndex: Int?
    // An apparent temperature
    var wc: Int?
    // Weather description qualifier code
    var qualifier: String?
    // Weather description qualifier severity
    var qualifierSvrty: String?
    // Weather description qualifier short phrase
    var bluntPhrase: String?
    // Weather description qualifier terse phrase
    var tersePhrase: String?
    // Barometric pressure is the pressure exerted by the atmosphere at the earth's surface, due to the weight of the air
    var pressure: Double?
    // Cloud cover description code
    var clds: String?
    // The horizontal visibility at the observation point
    var vis: Double?
    // Wind speed
    var wspd: Int?
    // Wind gust speed
    var gust: Int?
    // The direction from which the wind blows expressed in degrees
    var wdir: Int?
    // Precipitation amount in the last 24 hours
    var precipTotal: Float?
    // Precipitation for the last hour
    var precipHrly: Float?
    // Snow increasing rapidly in inches or centimeters per hour depending on whether or not the snowfall is reported by METAR or TECCI (synthetic observations)
    var snowHrly: Float?
    // Ultraviolet index
    var uvIndex: Int?
    // Ultraviolet index description
    var uvDesc: String?

    required public init?(map: Map) {

    }

    open func mapping(map: Map) {
        key <- map["key"]
        _class <- map["class"]
        expireTimeGmt <- map["expire_time_gmt"]
        obsId <- map["obs_id"]
        obsName <- map["obs_name"]
        validTimeGmt <- map["valid_time_gmt"]
        wxIcon <- map["wx_icon"]
        iconExtd <- map["icon_extd"]
        temp <- map["temp"]
        wxPhrase <- map["wx_phrase"]
        pressureDesc <- map["pressure_desc"]
        pressureTend <- map["pressure_tend"]
        wdirCardinal <- map["wdir_cardinal"]
        dayInd <- map["day_ind"]
        maxTemp <- map["max_temp"]
        minTemp <- map["min_temp"]
        dewpt <- map["dewpt"]
        rh <- map["rh"]
        feelsLike <- map["feels_like"]
        heatIndex <- map["heat_index"]
        wc <- map["wc"]
        qualifier <- map["qualifier"]
        qualifierSvrty <- map["qualifier_svrty"]
        bluntPhrase <- map["blunt_phrase"]
        tersePhrase <- map["terse_phrase"]
        pressure <- map["pressure"]
        clds <- map["clds"]
        vis <- map["vis"]
        wspd <- map["wspd"]
        gust <- map["gust"]
        wdir <- map["wdir"]
        precipTotal <- map["precip_total"]
        precipHrly <- map["precip_hrly"]
        snowHrly <- map["snow_hrly"]
        uvIndex <- map["uv_index"]
        uvDesc <- map["uv_desc"]
    }
}
