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

import UIKit

class Forecast: UITableViewController {

    var forecast: DailyForecast?

    override func numberOfSections(in: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecast?.forecasts?.count ?? 0
    }

    override func tableView(_: UITableView, cellForRowAt: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: cellForRowAt as IndexPath) as? ForecastCell else {
            return UITableViewCell()
        }

        /// Ensure there is forecast data for the cell
        guard let entry = forecast?.forecasts?[cellForRowAt.row] else {
            return UITableViewCell()
        }

        /// Retrieve the current observation data
        let daily: Daily!

        if let day = entry.day {
            daily = day
        } else if let night = entry.night {
            daily = night
        } else {
            return UITableViewCell()
        }

        /// Set the current temperature
        if let temp = daily.temp {
            cell.temp.text = "\(temp)\u{00B0}"
        } else {
            cell.temp.text = "--"
        }

        /// Setup the cell
        cell.day.text = daily.daypartName
        cell.forecastDescription.lineBreakMode = .byWordWrapping
        cell.forecastDescription.numberOfLines = 0
        cell.forecastDescription.text = entry.narrative ?? "na"

        /// Set the appropriate icon
        if let iconCode = daily.iconCode {
            cell.iconImage.image = UIImage(named: "\(iconCode)")
        } else {
            cell.iconImage.image = UIImage(named: "na")
        }

        return cell
    }
}
