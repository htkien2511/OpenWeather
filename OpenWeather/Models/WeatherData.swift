//
//  WeatherData.swift
//  OpenWeather
//
//  Created by Hoang Trong Kien on 6/11/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

struct WeatherData {
  let id: Int
  let weather: [Weather]
  let clouds: Clouds
  let main: Main
  let wind: Wind
  
  init(id: Int, weather: [Weather], clouds: Clouds, main: Main, wind: Wind) {
    self.id = id
    self.weather = weather
    self.clouds = clouds
    self.main = main
    self.wind = wind
  }
}

extension WeatherData: JSONDecodable {
  init?(JSON: Any) {
    guard let JSON = JSON as? [String: AnyObject] else { return nil }
    guard let id = JSON["id"] as? Int else { return nil }
    guard let clouds = JSON["clouds"] else { return nil }
    guard let main = JSON["main"] else { return nil }
    guard let wind = JSON["wind"] else { return nil }
    guard let weather = JSON["weather"] as? [[String: AnyObject]] else { return nil }
    
    var buffer = [Weather]()
    buffer.append(Weather.init(JSON: weather[0])!)
    
    self.id = id
    self.weather = buffer
    self.clouds = Clouds.init(JSON: clouds)!
    self.main = Main.init(JSON: main)!
    self.wind = Wind.init(JSON: wind)!
  }  
}


