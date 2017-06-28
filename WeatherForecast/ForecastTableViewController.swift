//
//  ForecastTableViewController.swift
//  WeatherForecast
//
//  Created by Wismin Effendi on 6/28/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    // pass in this value via segue
    var cityName: String!
    
    
    var forecasts = [Forecast]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = cityName
        populateForecastsForCity()
    
    }
    
    
    private func populateForecastsForCity() {
        func getWeatherForecastData(urlString: String) {
            let url = URL(string: urlString)
            let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, response, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                DispatchQueue.main.async(execute: {
                    self?.populateForecasts(data!)
                })
            }
            task.resume()
        }
        
        let encodedString = Util.getUrlEncodedStringOf(cityName)
        let openWeatherURL = "http://api.openweathermap.org/data/2.5/forecast?q=\(encodedString)&appid=1d6c50963fee0c46f1648017dd3a9367"
        
        getWeatherForecastData(urlString: openWeatherURL)
    }
    
    private func populateForecasts(_ weatherData: Data) {
        do {
            let jsonDict = try JSONSerialization.jsonObject(with: weatherData, options: []) as! NSDictionary
            let timestamps = jsonDict.value(forKeyPath: "list.dt") as! [Double]
            let temperaturesInKelvin = jsonDict.value(forKeyPath: "list.main.temp") as! [Double]
            let weatherDescriptions = jsonDict.value(forKeyPath: "list.weather.description") as! [[String]]
            
            var tsIterator = timestamps.makeIterator()
            var kelvinIterator = temperaturesInKelvin.makeIterator()
            var descIterator = weatherDescriptions.makeIterator()
            
            while let timestamp = tsIterator.next(), let kelvinTemp = kelvinIterator.next(), let description = descIterator.next() {
                let forecast = Forecast(dateTime: Util.dateTimeStringFromUnixTimeStamp(timestamp), temperatureInKelvin: kelvinTemp, description: description.first!)
                forecasts.append(forecast)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)

        let forecast = forecasts[indexPath.row]
        cell.textLabel?.text = forecast.dateTime
        cell.detailTextLabel?.text = forecast.tempAndDescription
        
        return cell
    }

}
