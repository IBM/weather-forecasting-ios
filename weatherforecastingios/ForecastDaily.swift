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

open class ForecastDaily: Mappable {
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

    required public init?(map: Map) {

    }

    open func mapping(map: Map) {
        _class <- map["class"]
        expireTimeGmt <- map["expire_time_gmt"]
        fcstValid <- map["fcst_valid"]
        fcstValidLocal <- map["fcst_valid_local"]
        num <- map["num"]
        maxTemp <- map["max_temp"]
        minTemp <- map["min_temp"]
        blurb <- map["blurb"]
        blurbAuthor <- map["blurb_author"]
        dow <- map["dow"]
        lunarPhaseCode <- map["lunar_phase_code"]
        lunarPhase <- map["lunar_phase"]
        lunarPhaseDay <- map["lunar_phase_day"]
        sunrise <- map["sunrise"]
        sunset <- map["sunset"]
        qualifierCode <- map["qualifier_code"]
        qualifier <- map["qualifier"]
        narrative <- map["narrative"]
        qpf <- map["qpf"]
        torcon <- map["torcon"]
        stormcon <- map["stormcon"]
        moonrise <- map["moonrise"]
        moonset <- map["moonset"]
        snowQpf <- map["snow_qpf"]
        snowRange <- map["snow_range"]
        snowPhrase <- map["snow_phrase"]
        snowCode <- map["snow_code"]
        day <- map["day"]
        night <- map["night"]
    }
}
