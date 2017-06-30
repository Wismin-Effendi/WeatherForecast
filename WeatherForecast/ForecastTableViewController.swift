//
//  ForecastTableViewController.swift
//  WeatherForecast
//
//  Created by Wismin Effendi on 6/28/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ForecastTableViewController: UITableViewController {
    
    // pass in this value via segue
    var cityName: String = ""
    
    
    var forecasts: [Forecast2] = [Forecast2]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = cityName
        populateForecastsForCity()
    }
    
    
    private func populateForecastsForCity() {
        func getWeatherForecastData(urlString: String) {
            Alamofire.request(urlString).responseObject { [weak self] (response: DataResponse<WeatherResponse>) in
                guard response.error == nil else {
                    self?.showAlertErrorMessage(code: "", message: response.error!.localizedDescription)
                    print("Error from response...")
                    return
                }
                
                guard response.result.error == nil else {
                    self?.showAlertErrorMessage(code: "", message: response.result.error!.localizedDescription)
                    print("Error from response.result...")
                    return
                }
                
                let weatherResponse = response.result.value
                print("**********")
                print(weatherResponse ?? "Nothing in weatherResponse???")
                if let fiveDayForecast = weatherResponse?.fiveDayForecast {
                    print("Successful get fiveDay Forecast..")
                    for forecast in fiveDayForecast {
                        print(forecast.dateTime)
                        print(forecast)
                    }
                    
                    self?.forecasts = fiveDayForecast
                }
                
                self?.tableView.reloadData()
            }
        }
        
        let encodedString = Util.getUrlEncodedStringOf(cityName)
        let openWeatherURL = "http://api.openweathermap.org/data/2.5/forecast?q=\(encodedString)&appid=1d6c50963fee0c46f1648017dd3a9367"
        
        getWeatherForecastData(urlString: openWeatherURL)
    }
    

    
    private func showAlertErrorMessage(code: String, message: String ) {
        let errorMessage = "Error \(code): \(message)"
        let alertError = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
        alertError.addAction(dismissAction)
        present(alertError, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of row in table: \(forecasts.count)")
        return forecasts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)

        let forecast = forecasts[indexPath.row]
        cell.textLabel?.text = forecast.dateTime
        cell.detailTextLabel?.text = forecast.description
        
        return cell
    }
    
    // to get rid of extra empty cell with border
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

}
