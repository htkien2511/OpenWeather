//
//  Wind.swift
//  OpenWeather
//
//  Created by Hoang Trong Kien on 6/11/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

struct Wind {
  let speed: Double
  
  init(speed: Double) {
    self.speed = speed
  }
}

extension Wind: JSONDecodable {
  init?(JSON: Any) {
    guard let JSON = JSON as? [String: AnyObject] else { return nil }
    guard let speed = JSON["speed"] as? Double else { return nil }
    
    self.speed = speed
  }
}
