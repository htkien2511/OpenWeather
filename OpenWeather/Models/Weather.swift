//
//  Weather.swift
//  OpenWeather
//
//  Created by Hoang Trong Kien on 6/11/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

struct Weather {
  let description: String
  let icon: String
  
  init(description: String, icon: String) {
    self.description = description
    self.icon = icon
  }
}

extension Weather: JSONDecodable {
  init?(JSON: Any) {
    guard let JSON = JSON as? [String: AnyObject] else { return nil }
    guard let description = JSON["description"] as? String else { return nil }
    guard let icon = JSON["icon"] as? String else { return nil }
    
    self.description = description
    self.icon = icon
  }
}
