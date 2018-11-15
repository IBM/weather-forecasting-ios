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

struct Observation {
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
}

// Mark - Decodable Conformance

// Can be automatically synthesized in Swift 4.1
extension Observation: Decodable {

    enum CodingKeys: String, CodingKey {
        case key
        case _class = "class"
        case expireTimeGmt = "expire_time_gmt"
        case obsId = "obs_id"
        case obsName = "obs_name"
        case validTimeGmt = "valid_time_gmt"
        case wxIcon = "wx_icon"
        case iconExtd = "icon_extd"
        case temp
        case wxPhrase = "wx_phrase"
        case pressureDesc = "pressure_desc"
        case pressureTend = "pressure_tend"
        case wdirCardinal = "wdir_cardinal"
        case dayInd = "day_ind"
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case dewpt
        case rh
        case feelsLike = "feels_like"
        case heatIndex = "heat_index"
        case wc
        case qualifier
        case qualifierSvrty = "qualifier_svrty"
        case bluntPhrase = "blunt_phrase"
        case tersePhrase = "terse_phrase"
        case pressure
        case clds
        case vis
        case wspd
        case gust
        case wdir
        case precipTotal = "percip_total"
        case precipHrly = "percip_hrly"
        case snowHrly = "snow_hrly"
        case uvIndex = "uv_index"
        case uvDesc = "uv_desc"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        key = try? values.decode(String.self, forKey: .key)
        _class = try? values.decode(String.self, forKey: ._class)
        expireTimeGmt = try? values.decode(Double.self, forKey: .expireTimeGmt)
        obsId = try? values.decode(String.self, forKey: .obsId)
        obsName = try? values.decode(String.self, forKey: .obsName)
        validTimeGmt = try? values.decode(Double.self, forKey: .validTimeGmt)
        wxIcon = try? values.decode(Int.self, forKey: .wxIcon)
        iconExtd = try? values.decode(Int.self, forKey: .iconExtd)
        temp = try? values.decode(Int.self, forKey: .temp)
        wxPhrase = try? values.decode(String.self, forKey: .wxPhrase)
        pressureDesc = try? values.decode(String.self, forKey: .pressureDesc)
        pressureTend = try? values.decode(Int.self, forKey: .pressureTend)
        wdirCardinal = try? values.decode(String.self, forKey: .wdirCardinal)
        dayInd = try? values.decode(String.self, forKey: .dayInd)
        maxTemp = try? values.decode(Int.self, forKey: .maxTemp)
        minTemp = try? values.decode(Int.self, forKey: .minTemp)
        dewpt = try? values.decode(Int.self, forKey: .dewpt)
        rh = try? values.decode(Int.self, forKey: .rh)
        feelsLike = try? values.decode(Int.self, forKey: .feelsLike)
        heatIndex = try? values.decode(Int.self, forKey: .heatIndex)
        wc = try? values.decode(Int.self, forKey: .wc)
        qualifier = try? values.decode(String.self, forKey: .qualifier)
        qualifierSvrty = try? values.decode(String.self, forKey: .qualifierSvrty)
        bluntPhrase = try? values.decode(String.self, forKey: .bluntPhrase)
        tersePhrase = try? values.decode(String.self, forKey: .tersePhrase)
        pressure = try? values.decode(Double.self, forKey: .pressure)
        clds = try? values.decode(String.self, forKey: .clds)
        vis = try? values.decode(Double.self, forKey: .vis)
        wspd = try? values.decode(Int.self, forKey: .wspd)
        gust = try? values.decode(Int.self, forKey: .gust)
        wdir = try? values.decode(Int.self, forKey: .wdir)
        precipTotal = try? values.decode(Float.self, forKey: .precipTotal)
        precipHrly = try? values.decode(Float.self, forKey: .precipHrly)
        snowHrly = try? values.decode(Float.self, forKey: .snowHrly)
        uvIndex = try? values.decode(Int.self, forKey: .uvIndex)
        uvDesc = try? values.decode(String.self, forKey: .uvDesc)
    }
}
