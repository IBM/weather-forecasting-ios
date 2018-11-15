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
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
