//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
  
  //Constants
  //  TODO: Delete old URL after checking that new one works
  //  let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  
  let WEATHER_URL = "api.openweathermap.org/data/2.5/weather"
  let APP_ID = "3e220a028b2eb8a65795f2a02e6cbd7e"
  
  
  //TODO: Declare instance variables here
  let locationManager = CLLocationManager()
  
  
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
  
  
  
  
  
  
  
  //MARK: - JSON Parsing
  /***************************************************************/
  
  
  //Write the updateWeatherData method here:
  
  
  
  
  
  //MARK: - UI Updates
  /***************************************************************/
  
  
  //Write the updateUIWithWeatherData method here:
  
  
  
  
  
  
  //MARK: - Location Manager Delegate Methods
  /***************************************************************/
  
  
  //Write the didUpdateLocations method here:
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[locations.count - 1]
    if location.horizontalAccuracy > 0 {
      locationManager.stopUpdatingLocation()
      print("latitude = \(location.coordinate.latitude), longitude = \(location.coordinate.longitude)")
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


