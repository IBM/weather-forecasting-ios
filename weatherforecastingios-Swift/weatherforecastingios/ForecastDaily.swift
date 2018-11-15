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

struct ForecastDaily {
    // The data identifier
    var _class: String?
    // The expiration time in UNIX seconds
    var expireTimeGmt: Double?
    // The valid time forecast in UNIX seconds
    var fcstValid: Double?
    // The valid time forecast in local apparent time
    var fcstValidLocal: Date?
    // The sequential number that identifies each of the forecasted days in the API
    var num: Int?
    // The daily maximum temperature
    var maxTemp: Int?
    // The daily minimum temperature
    var minTemp: Int?
    // A handwritten local or regional text forecast created by a meteorologist to supplement the system generated forecast
    var blurb: String?
    // The name initials of the meteorologist who authored the forecast blurb
    var blurbAuthor: String?
    // The day of the week
    var dow: String?
    // The three-character short code for lunar phases
    var lunarPhaseCode: String?
    // A descriptive phrase for the current lunar phase
    var lunarPhase: String?
    // The day number in the monthly lunar cycle
    var lunarPhaseDay: Int?
    // The local time of the sunrise
    var sunrise: Date?
    // The local time of the sunset
    var sunset: Date?
    // A code for special forecasted weather criteria for the 12- and 24-hour day parts
    var qualifierCode: String?
    // A phrase associated with the qualifier_code that describes special forecasted weather criteria for the 12- and 24-hour day parts
    var qualifier: String?
    // The narrative forecast for the 24-hour period
    var narrative: String?
    // The forecasted measurable precipitation (liquid or liquid equivalent) during the 12- or 24-hour forecast period
    var qpf: Float?
    // The estimate of the likelihood of tornado activity during a given 24-hour forecast period
    var torcon: Int?
    // The estimate of the likelihood of winter storm activity during a given 24-hour forecast period
    var stormcon: Int?
    // The first moonrise in local time
    var moonrise: Date?
    // The first moonset in local time
    var moonset: Date?
    // The forecasted measurable precipitation as snow during the 12- or 24-hour forecast period
    var snowQpf: Float?
    // The expected amount of residual snow for the 12- or 24-hour forecast period
    var snowRange: String?
    // A shortened text description of the forecasted​ ​snow accumulation during the 12- or 24-hour forecast period
    var snowPhrase: String?
    // The residual snow accumulation code for the 12- or 24-hour forecast period
    var snowCode: String?
    var day: Daily?
    var night: Daily?
}

// Mark - Decodable Conformance

// Can be automatically synthesized in Swift 4.1
extension ForecastDaily: Decodable {

    enum CodingKeys: String, CodingKey {
        case _class = "class"
        case expireTimeGmt = "expire_time_gmt"
        case fcstValid = "fcst_valid"
        case fcstValidLocal = "fcst_valid_local"
        case num
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case blurb
        case blurbAuthor = "blurb_author"
        case dow
        case lunarPhaseCode = "lunar_phase_code"
        case lunarPhase = "lunar_phase"
        case lunarPhaseDay = "lunar_phase_day"
        case sunrise
        case sunset
        case qualifierCode = "qualifier_code"
        case qualifier
        case narrative
        case qpf
        case torcon
        case stormcon
        case moonrise = "moonrise"
        case moonset = "moonset"
        case snowQpf = "snow_qpf"
        case snowRange = "snow_range"
        case snowPhrase = "snow_phrase"
        case snowCode = "snow_code"
        case day
        case night
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        _class = try? values.decode(String.self, forKey: ._class)
        expireTimeGmt = try? values.decode(Double.self, forKey: .expireTimeGmt)
        fcstValid = try? values.decode(Double.self, forKey: .fcstValid)
        fcstValidLocal = try? values.decode(Date.self, forKey: .fcstValidLocal)
        num = try? values.decode(Int.self, forKey: .num)
        maxTemp = try? values.decode(Int.self, forKey: .maxTemp)
        minTemp = try? values.decode(Int.self, forKey: .minTemp)
        blurb = try? values.decode(String.self, forKey: .blurb)
        blurbAuthor = try? values.decode(String.self, forKey: .blurbAuthor)
        dow = try? values.decode(String.self, forKey: .dow)
        lunarPhaseCode = try? values.decode(String.self, forKey: .lunarPhaseCode)
        lunarPhase = try? values.decode(String.self, forKey: .lunarPhase)
        lunarPhaseDay = try? values.decode(Int.self, forKey: .lunarPhaseDay)
        sunrise = try? values.decode(Date.self, forKey: .sunrise)
        sunset = try? values.decode(Date.self, forKey: .sunset)
        qualifierCode = try? values.decode(String.self, forKey: .qualifierCode)
        qualifier = try? values.decode(String.self, forKey: .qualifier)
        narrative = try? values.decode(String.self, forKey: .narrative)
        qpf = try? values.decode(Float.self, forKey: .qpf)
        torcon = try? values.decode(Int.self, forKey: .torcon)
        stormcon = try? values.decode(Int.self, forKey: .stormcon)
        moonrise = try? values.decode(Date.self, forKey: .moonrise)
        moonset = try? values.decode(Date.self, forKey: .moonset)
        snowQpf = try? values.decode(Float.self, forKey: .snowQpf)
        snowRange = try? values.decode(String.self, forKey: .snowRange)
        snowPhrase = try? values.decode(String.self, forKey: .snowPhrase)
        snowCode = try? values.decode(String.self, forKey: .snowCode)
        day = try? values.decode(Daily.self, forKey: .day)
        night = try? values.decode(Daily.self, forKey: .night)
    }
}
