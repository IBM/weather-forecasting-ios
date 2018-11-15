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

open class Daily: Mappable {
    // The data identifier
    var _class: String?
    // The expiration time in UNIX seconds
    var expireTimeGmt: Double?
    // The valid time forecast in UNIX seconds
    var fcstValid: Double?
    // The valid time forecast in local apparent time
    var fcstValidLocal: Date?
    // The day or night indicator
    var dayInd: String?
    // The enumeration of thunderstorm probability within an area for a 12-hour day part
    var thunderEnum: Int?
    // The description of probability thunderstorm activity in an area for 12-hour day part
    var thunderEnumPhrase: String?
    // The name of a 12-hour day part not including day names in the first 48 hours
    var daypartName: String?
    // The named time frame for the valid weather forecast in an expanded format
    var longDaypartName: String?
    // A specialized version of the daypart_name field 
    // Certain holidays or historic events may replace the usual daypart_name
    var altDaypartName: String?
    // The sequential number that identifies each of the forecasted days in your feed
    var num: Int?
    // The forecasted temperature for midpoint day (1pm) or midpoint night (1am) for a 12-hour day part
    var temp: Int?
    // The short phrase containing the forecasted high or low temperature for 12-hour forecast period
    var tempPhrase: String?
    // The daytime maximum heat index
    var hi: Int?
    // The nighttime minimum wind chill
    var wc: Int?
    // The daytime maximum probability of precipitation
    var pop: Int?
    // The daytime probability of precipitation phrase
    var popPhrase: String?
    // A code that represents explicit full set sensible weather
    var iconExtd: Int?
    // The key to the weather icon lookup. 
    var iconCode: Int?
    // The code to enable the Weather Man animation for forecast period (TWC use only)
    var wxman: String?
    // The daytime sensible weather phrase
    var phrase32char: String?
    // The daytime sensible weather phrase
    var phrase22char: String?
    // The daytime sensible weather phrase
    var phrase12char: String?
    // Part 1 of 3-part daytime sensible weather phrase
    var subphrasePt1: String?
    // Part 2 of 3-part daytime sensible weather phrase
    var subphrasePt2: String?
    // Part 3 of 3-part daytime sensible weather phrase
    var subphrasePt3: String?
    // The type of precipitation to display with the probability of precipitation (POP) data element
    var precipType: String?
    // The daytime relative humidity of the air, which is defined as the ratio of the amount of water vapor in the air to the amount of vapor required to bring the air to saturation at a constant temperature
    var rh: Int?
    // The maximum forecasted daytime wind speed
    var wspd: Int?
    // The daytime average wind direction in magnetic notation
    var wdir: Int?
    // The daytime average wind direction in cardinal notation
    var wdirCardinal: String?
    // The phrase that describes the wind direction and speed for a 12-hour day part
    var windPhrase: String?
    // The daytime average cloud cover expressed as a percentage
    var clds: Int?
    // An abbreviated sensible weather portion of narrative forecast
    var shortcast: String?
    // The narrative forecast for the daytime period
    var narrative: String?
    // The forecasted measurable precipitation (liquid or liquid equivalent) during the 12-hour forecast period
    var qpf: Float?
    // An accumulation phrase of any precipitation type in the 12-hour forecast period
    var accumulationPhrase: String?
    // The forecasted measurable precipitation as snow during the 12-hour forecast period
    var snowQpf: Float?
    // Snow accumulation amount for the 12-hour forecast period
    var snowRange: String?
    // Snow accumulation phrase for the 12-hour forecast period
    var snowPhrase: String?
    // Residual snow accumulation code for the 12- or 24-hour forecast period
    var snowCode: String?
    // An encoded narrative forecast used for creating computer-generated audio narratives of the forecast period (TWC use only)
    var vocalKey: String?
    // A forecast qualifier that is applicable to the 12-hour forecast period
    var qualifier: String?
    // A code for the forecast qualifier applicable to the 12-hour forecast period
    var qualifierCode: String?
    // The non-truncated UV index which is the intensity of the solar radiation based on a number of factors
    var uvIndexRaw: Float?
    // Maximum UV index for the 12-hour forecast period
    var uvIndex: Int?
    // The UV index description, which complements the UV index value by providing an associated level of risk of skin damage due to exposure
    var uvDesc: String?
    // The UV warning that is based on a UV index of 11 or greater
    var uvWarning: Int?
    // The weather conditions for playing golf expressed on a scale of 0 to 10
    var golfIndex: Int?
    // The golf index category expressed as a phrase for the weather conditions for playing golf
    var golfCategory: String?

    required public init?(map: Map) {

    }

    open func mapping(map: Map) {
        _class <- map["class"]
        expireTimeGmt <- map["expire_time_gmt"]
        fcstValid <- map["fcst_valid"]
        fcstValidLocal <- map["fcst_valid_local"]
        dayInd <- map["day_ind"]
        thunderEnum <- map["thunder_enum"]
        thunderEnumPhrase <- map["thunder_enum_phrase"]
        daypartName <- map["daypart_name"]
        longDaypartName <- map["long_daypart_name"]
        altDaypartName <- map["alt_ daypart_name"]
        num <- map["num"]
        temp <- map["temp"]
        tempPhrase <- map["temp_phrase"]
        hi <- map["hi"]
        wc <- map["wc"]
        pop <- map["pop"]
        popPhrase <- map["pop_phrase"]
        iconExtd <- map["icon_extd"]
        iconCode <- map["icon_code"]
        wxman <- map["wxman"]
        phrase32char <- map["phrase_32char"]
        phrase22char <- map["phrase_22char"]
        phrase12char <- map["phrase_12char"]
        subphrasePt1 <- map["subphrase_pt1"]
        subphrasePt2 <- map["subphrase_pt2"]
        subphrasePt3 <- map["subphrase_pt3"]
        precipType <- map["precip_type"]
        rh <- map["rh"]
        wspd <- map["wspd"]
        wdir <- map["wdir"]
        wdirCardinal <- map["wdir_cardinal"]
        windPhrase <- map["wind_phrase"]
        clds <- map["clds"]
        shortcast <- map["shortcast"]
        narrative <- map["narrative"]
        qpf <- map["qpf"]
        accumulationPhrase <- map["accumulation_phrase"]
        snowQpf <- map["snow_qpf"]
        snowRange <- map["snow_range"]
        snowPhrase <- map["snow_phrase"]
        snowCode <- map["snow_code"]
        vocalKey <- map["vocal_key"]
        qualifier <- map["qualifier"]
        qualifierCode <- map["qualifier_code"]
        uvIndexRaw <- map["uv_index_raw"]
        uvIndex <- map["uv_index"]
        uvDesc <- map["uv_desc"]
        uvWarning <- map["uv_warning"]
        golfIndex <- map["golf_index"]
        golfCategory <- map["golf_category"]
    }
}
