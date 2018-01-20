//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
  
  //Constants
  let weatherURL = "http://api.openweathermap.org/data/2.5/weather"
  let appID = "3e220a028b2eb8a65795f2a02e6cbd7e"
  
  
  //TODO: Declare instance variables here
  let locationManager = CLLocationManager()
  let weatherDataModel = WeatherDataModel()
  
  
  //Pre-linked IBOutlets
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    //TODO:Set up the location manager here.
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
  }
  
  
  
  //MARK: - Networking
  /***************************************************************/
  
  //Write the getWeatherData method here:
  func getWeatherData(url: String, parameters: [String: String]) {
    
    Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
      response in
      if response.result.isSuccess {
        print("Success! Got the weather data.")
        
        let weatherJSON: JSON = JSON(response.result.value!)
        self.updateWeatherData(json: weatherJSON)
        
      } else {
        print("Error \(response.result.error ?? "retrieving data from servers." as! Error)")
        self.cityLabel.text = "Connection Issues"
      }
    }
    
  }
  
  
  
  
  
  
  //MARK: - JSON Parsing
  /***************************************************************/
  
  
  //Write the updateWeatherData method here:
  func updateWeatherData(json: JSON) {
    if let temperatureResult = json["main"]["temp"].double {
      
      // Temperature has to be converted from Kelvin to Fahrenheit
      weatherDataModel.temperature = Int((1.8 * (temperatureResult - 273.15)) + 32)
      weatherDataModel.city = json["name"].stringValue
      weatherDataModel.condition = json["weather"][0]["id"].intValue
      weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
      
      updateUIWithWeatherData()
      
    } else {
      cityLabel.text = "Weather Unavailable"
    }
  }
  
  
  
  
  //MARK: - UI Updates
  /***************************************************************/
  
  
  //Write the updateUIWithWeatherData method here:
  func updateUIWithWeatherData() {
    weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    cityLabel.text = weatherDataModel.city
    temperatureLabel.text = "\(weatherDataModel.temperature) °F"
  }
  
  
  
  
  
  //MARK: - Location Manager Delegate Methods
  /***************************************************************/
  
  
  //Write the didUpdateLocations method here:
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[locations.count - 1]
    if location.horizontalAccuracy > 0 {
      locationManager.stopUpdatingLocation()
      
      //This will stop the delegate from receiving the JSON data from
      //openweathermap.org more than once.
      locationManager.delegate = nil
      
      print("latitude = \(location.coordinate.latitude), longitude = \(location.coordinate.longitude)")
      
      let latitude = String(location.coordinate.latitude)
      let longitude = String(location.coordinate.longitude)
      let params: [String: String] = ["lat": latitude, "lon": longitude, "appid": appID]
      getWeatherData(url: weatherURL, parameters: params)
    }
  }
  
  
  
  //Write the didFailWithError method here:
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
    cityLabel.text = "Location Unavailable"
  }
  
  
  
  
  //MARK: - Change City Delegate methods
  /***************************************************************/
  
  
  //Write the userEnteredANewCityName Delegate method here:
  
  
  
  //Write the PrepareForSegue Method here
  
  
  
  
  
}


