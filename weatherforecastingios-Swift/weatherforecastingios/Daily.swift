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

struct Daily {
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
}

// Mark - Decodable Conformance

// Can be automatically synthesized in Swift 4.1
extension Daily: Decodable {

    enum CodingKeys: String, CodingKey {
        case _class = "class"
        case expireTimeGmt = "expire_time_gmt"
        case fcstValid = "fcst_valid"
        case fcstValidLocal = "fcst_valid_local"
        case dayInd = "day_ind"
        case thunderEnum = "thunder_enum"
        case thunderEnumPhrase = "thunder_enum_phrase"
        case daypartName = "daypart_name"
        case longDaypartName = "long_daypart_name"
        case altDaypartName = "alt_daypart_name"
        case num
        case temp
        case tempPhrase = "temp_phrase"
        case hi
        case wc
        case pop
        case popPhrase = "pop_phrase"
        case iconExtd = "icon_extd"
        case iconCode = "icon_code"
        case wxman
        case phrase32char = "phrase_32_char"
        case phrase22char = "phrase_22_char"
        case phrase12char = "phrase_12_char"
        case subphrasePt1 = "subphrasePt1"
        case subphrasePt2 = "subphrasePt2"
        case subphrasePt3 = "subphrasePt3"
        case precipType = "percip_type"
        case rh
        case wspd
        case wdir
        case wdirCardinal = "wdir_cardinal"
        case windPhrase = "wdir_phrase"
        case clds
        case shortcast
        case narrative
        case qpf
        case accumulationPhrase = "accumulation_phrase"
        case snowQpf = "snow_qpf"
        case snowRange = "snow_range"
        case snowPhrase = "snow_phrase"
        case snowCode = "snow_code"
        case vocalKey = "vocal_key"
        case qualifier
        case qualifierCode = "qualifier_code"
        case uvIndexRaw = "uv_index_raw"
        case uvIndex = "uv_index"
        case uvDesc = "uv_desc"
        case uvWarning = "uv_warning"
        case golfIndex = "gold_index"
        case golfCategory = "gold_category"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        _class = try? values.decode(String.self, forKey: ._class)
        expireTimeGmt = try? values.decode(Double.self, forKey: .expireTimeGmt)
        fcstValid = try? values.decode(Double.self, forKey: .fcstValid)
        fcstValidLocal = try? values.decode(Date.self, forKey: .fcstValidLocal)
        dayInd = try? values.decode(String.self, forKey: .dayInd)
        thunderEnum = try? values.decode(Int.self, forKey: .thunderEnum)
        thunderEnumPhrase = try? values.decode(String.self, forKey: .thunderEnumPhrase)
        daypartName = try? values.decode(String.self, forKey: .daypartName)
        longDaypartName = try? values.decode(String.self, forKey: .longDaypartName)
        altDaypartName = try? values.decode(String.self, forKey: .altDaypartName)
        num = try? values.decode(Int.self, forKey: .num)
        temp = try? values.decode(Int.self, forKey: .temp)
        tempPhrase = try? values.decode(String.self, forKey: .tempPhrase)
        hi = try? values.decode(Int.self, forKey: .hi)
        wc = try? values.decode(Int.self, forKey: .wc)
        pop = try? values.decode(Int.self, forKey: .popPhrase)
        popPhrase = try? values.decode(String.self, forKey: ._class)
        iconExtd = try? values.decode(Int.self, forKey: .iconExtd)
        iconCode = try? values.decode(Int.self, forKey: .iconCode)
        wxman = try? values.decode(String.self, forKey: .wxman)
        phrase32char = try? values.decode(String.self, forKey: .phrase32char)
        phrase22char = try? values.decode(String.self, forKey: .phrase22char)
        phrase12char = try? values.decode(String.self, forKey: .phrase12char)
        subphrasePt1 = try? values.decode(String.self, forKey: .subphrasePt1)
        subphrasePt2 = try? values.decode(String.self, forKey: .subphrasePt2)
        subphrasePt3 = try? values.decode(String.self, forKey: .subphrasePt3)
        precipType = try? values.decode(String.self, forKey: .precipType)
        rh = try? values.decode(Int.self, forKey: .rh)
        wspd = try? values.decode(Int.self, forKey: .wspd)
        wdir = try? values.decode(Int.self, forKey: .wdir)
        wdirCardinal = try? values.decode(String.self, forKey: .wdirCardinal)
        windPhrase = try? values.decode(String.self, forKey: .windPhrase)
        clds = try? values.decode(Int.self, forKey: .clds)
        shortcast = try? values.decode(String.self, forKey: .shortcast)
        narrative = try? values.decode(String.self, forKey: .narrative)
        qpf = try? values.decode(Float.self, forKey: .qpf)
        accumulationPhrase = try? values.decode(String.self, forKey: .accumulationPhrase)
        snowQpf = try? values.decode(Float.self, forKey: .snowQpf)
        snowRange = try? values.decode(String.self, forKey: .snowRange)
        snowPhrase = try? values.decode(String.self, forKey: .snowPhrase)
        snowCode = try? values.decode(String.self, forKey: .snowCode)
        vocalKey = try? values.decode(String.self, forKey: .vocalKey)
        qualifier = try? values.decode(String.self, forKey: .qualifier)
        qualifierCode = try? values.decode(String.self, forKey: .qualifierCode)
        uvIndexRaw = try? values.decode(Float.self, forKey: .uvIndexRaw)
        uvIndex = try? values.decode(Int.self, forKey: .uvIndex)
        uvDesc = try? values.decode(String.self, forKey: .uvDesc)
        uvWarning = try? values.decode(Int.self, forKey: .uvWarning)
        golfIndex = try? values.decode(Int.self, forKey: .golfIndex)
        golfCategory = try? values.decode(String.self, forKey: .golfCategory)
    }
}
