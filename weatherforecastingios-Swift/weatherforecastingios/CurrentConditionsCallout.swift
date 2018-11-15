/*
 *     Copyright 2016,2017,2018 IBM Corp.
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

import UIKit

class CurrentConditionsCallout: UIView {

    @IBOutlet weak var currentIcon: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var bluntPhrase: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var narrative: UILabel!

    @IBOutlet weak var dayOne: UILabel!
    @IBOutlet weak var dayTwo: UILabel!
    @IBOutlet weak var dayThree: UILabel!
    @IBOutlet weak var iconOne: UIImageView!
    @IBOutlet weak var iconTwo: UIImageView!
    @IBOutlet weak var iconThree: UIImageView!
    @IBOutlet weak var tempOne: UILabel!
    @IBOutlet weak var tempTwo: UILabel!
    @IBOutlet weak var tempThree: UILabel!

    func setup(using weather: WeatherAnnotation) {
        // Setup the layer
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)

        // Set the image
        currentIcon.image = UIImage(named: "\(weather.observation.currentIcon)")

        if let title = weather.title, title.count > 20 {
            location.font.withSize(10.0)
        }
        location.text = weather.title

        currentTemperature.text = "\(weather.observation.currentTemperature)\u{00B0}"
        bluntPhrase.text = weather.observation.bluntPhrase
        bluntPhrase.lineBreakMode = .byWordWrapping
        bluntPhrase.numberOfLines = 0
        feelsLike.text = "\(weather.observation.feelsLike)\u{00B0}"
        humidity.text = "\(weather.observation.humidity)%"
        wind.text = "\(weather.observation.wind)mph \(weather.observation.windDir)"

        today.text = weather.forecast.today
        narrative.text = weather.forecast.narrative
        narrative.lineBreakMode = .byWordWrapping
        narrative.numberOfLines = 0
        dayOne.text = weather.forecast.dayOne
        dayTwo.text = weather.forecast.dayTwo
        dayThree.text = weather.forecast.dayThree
        iconOne.image = UIImage(named: "\(weather.forecast.iconOne)")
        iconTwo.image = UIImage(named: "\(weather.forecast.iconTwo)")
        iconThree.image = UIImage(named: "\(weather.forecast.iconThree)")
        tempOne.text = "\(weather.forecast.maxOne)\u{00B0} | \(weather.forecast.minOne)\u{00B0}"
        tempTwo.text = "\(weather.forecast.maxTwo)\u{00B0} | \(weather.forecast.minTwo)\u{00B0}"
        tempThree.text = "\(weather.forecast.maxThree)\u{00B0} | \(weather.forecast.minThree)\u{00B0}"
    }

}
