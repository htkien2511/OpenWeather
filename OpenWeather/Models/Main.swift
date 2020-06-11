//
//  Main.swift
//  OpenWeather
//
//  Created by Hoang Trong Kien on 6/11/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

struct Main {
  let temp: Double
  let humidity: Int
  
  init(temp: Double, humidity: Int) {
    self.temp = temp
    self.humidity = humidity
  }
}

extension Main: JSONDecodable {
  init?(JSON: Any) {
    guard let JSON = JSON as? [String: AnyObject] else { return nil }
    guard let temp = JSON["temp"] as? Double else { return nil }
    guard let humidity = JSON["humidity"] as? Int else { return nil }
    
    self.temp = temp
    self.humidity = humidity
  }
}
